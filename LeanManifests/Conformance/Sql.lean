import LeanManifests.Conformance

/-! # LeanManifests.Conformance.Sql — conformance harness for SQL (PostgreSQL)

Shape: table in (as schema + INSERT statements), query, table out (as CSV rows).
Reference: `psql -c '...'` or `sqlite3 :memory: '...'`
Comparison: row-set equality (unordered) or ordered equality (with ORDER BY).

## Why PostgreSQL as the reference

PostgreSQL is the most standards-compliant open-source SQL engine. When our
Lean table operations (GROUP BY, JOIN, window functions) need a reference
answer, PostgreSQL is the authority. SQLite is acceptable for simpler cases
but has type affinity quirks.

## Shapes this covers

- **DML**: SELECT, WHERE, GROUP BY, HAVING, ORDER BY, LIMIT
- **Joins**: INNER, LEFT, RIGHT, FULL OUTER, CROSS
- **Aggregates**: COUNT, SUM, AVG, MIN, MAX, STDDEV
- **Window functions**: ROW_NUMBER, RANK, LAG, LEAD, SUM OVER
- **Subqueries**: IN, EXISTS, scalar subquery

## Golden fixture example: GROUP BY with AVG
-/

set_option autoImplicit false

namespace LeanManifests.Conformance.Sql
open LeanManifests.Conformance

-- ════════════════════════════════════════════════════════════
-- § SQL-specific helpers
-- ════════════════════════════════════════════════════════════

/-- Build a psql command that creates a temp table, inserts data, and runs a query. -/
def psqlCommand (setup : String) (query : String) : String :=
  s!"psql -t -A -F',' -c \"{setup} {query}\""

/-- Build a sqlite3 command. -/
def sqliteCommand (setup : String) (query : String) : String :=
  s!"sqlite3 :memory: \"{setup} .mode csv {query}\""

/-- Standard fixture metadata for a SQL conformance check. -/
def sqlFixture (name : String) (cmd : String) (ordered : Bool := false) : Fixture :=
  { name
    reference := .postgresql
    command := cmd
    mode := if ordered then .exact else .rowSet }

-- ════════════════════════════════════════════════════════════
-- § Golden fixture: GROUP BY with AVG
-- ════════════════════════════════════════════════════════════

/-- Setup: a simple table with a group column and a value column. -/
private def setup : String :=
  "CREATE TEMP TABLE t(g TEXT, x NUMERIC); " ++
  "INSERT INTO t VALUES('a',1),('a',3),('b',2),('b',4),('b',6);"

/-- Query: average by group. -/
private def query : String :=
  "SELECT g, AVG(x) FROM t GROUP BY g ORDER BY g;"

/-- Expected output from PostgreSQL:
    ```
    a,2.0000000000000000
    b,4.0000000000000000
    ```
    (PostgreSQL returns NUMERIC with full precision)
-/
private def expected_rows : Array String := #["a,2", "b,4"]

def groupby_avg_golden : Fixture := sqlFixture "sql_groupby_avg"
  (psqlCommand setup query) (ordered := true)

-- ════════════════════════════════════════════════════════════
-- § Golden fixture: LEFT JOIN
-- ════════════════════════════════════════════════════════════

private def join_setup : String :=
  "CREATE TEMP TABLE orders(id INT, customer TEXT); " ++
  "CREATE TEMP TABLE customers(name TEXT, city TEXT); " ++
  "INSERT INTO customers VALUES('alice','NYC'),('bob','LA'),('carol','CHI'); " ++
  "INSERT INTO orders VALUES(1,'alice'),(2,'alice'),(3,'bob');"

private def join_query : String :=
  "SELECT c.name, COUNT(o.id) FROM customers c LEFT JOIN orders o ON c.name = o.customer GROUP BY c.name ORDER BY c.name;"

/-- Expected: alice has 2 orders, bob has 1, carol has 0. -/
private def join_expected : Array String := #["alice,2", "bob,1", "carol,0"]

def left_join_golden : Fixture := sqlFixture "sql_left_join"
  (psqlCommand join_setup join_query) (ordered := true)

-- ════════════════════════════════════════════════════════════
-- § Spec template
-- ════════════════════════════════════════════════════════════

/-- A SQL conformance spec for bulk generation. -/
structure SqlSpec where
  name : String
  /-- SQL setup template (CREATE TABLE + INSERTs). -/
  setupTemplate : String
  /-- SQL query template. -/
  queryTemplate : String
  /-- Number of random tables to generate. -/
  count : Nat := 20
  /-- Whether result order matters. -/
  ordered : Bool := false
  deriving Repr

/-- Example spec: test GROUP BY SUM on random data. -/
def groupby_sum_spec : SqlSpec :=
  { name := "sql_groupby_sum"
    setupTemplate := "CREATE TEMP TABLE t(g TEXT, x INT); INSERT INTO t VALUES {rows};"
    queryTemplate := "SELECT g, SUM(x) FROM t GROUP BY g ORDER BY g;"
    count := 30
    ordered := true }

end LeanManifests.Conformance.Sql
