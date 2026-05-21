import DeanLean.Basic

/-! # DeanLean.Conformance — framework for testing against reference systems

When your Lean implementation is meant to match an external system (R, numpy,
PostgreSQL, CommonMark spec, etc.), you need:

1. A **golden fixture** (checked in) — one hand-verified example that proves
   your implementation matches the reference on at least one input. This
   compiles without the reference system installed.

2. A **conformance spec** (checked in) — a recipe describing HOW to generate
   bulk test fixtures by running the reference system. This is a program
   that produces tests, not the tests themselves.

3. **Generated fixtures** (gitignored, in `.lake/conformance/`) — 10-1000
   machine-produced examples created by `lake run conformance:refresh`.
   These require the reference system to be installed.

## The four reference system shapes

Each shape has a different input/output format and comparison strategy:

### 1. Numeric (R, numpy, MATLAB)
- Input: arrays of floats
- Output: scalars or arrays of floats
- Comparison: approximate equality within tolerance (ε = 1e-10)
- Reference command: `Rscript -e '...'` or `python3 -c 'import numpy; ...'`

### 2. Relational (PostgreSQL, SQLite, DuckDB)
- Input: table (as INSERT statements or CSV)
- Output: table (as CSV rows)
- Comparison: row-set equality (order-independent) or ordered equality
- Reference command: `psql -c '...'` or `sqlite3 :memory: '...'`

### 3. Spec-fixture (CommonMark, HTML spec, RFC test vectors)
- Input: string (e.g. markdown source)
- Output: string (e.g. expected HTML)
- Comparison: exact string equality (or normalized)
- Reference: a spec.json file with example/expected pairs

### 4. Binary/crypto (OpenSSL, libsodium)
- Input: byte arrays (as hex strings)
- Output: byte arrays (as hex strings)
- Comparison: exact equality
- Reference command: `openssl enc ...` or test vectors from RFCs

## Usage

In your library (e.g. lean-stats):

```
MyLib/Conformance/
  R/
    Lm.lean          — golden fixture (checked in, always compiles)
    Lm.spec.lean     — spec: how to generate bulk fixtures
  Numpy/
    Matmul.lean      — golden fixture
    Matmul.spec.lean — spec
```

Run `lake run conformance:refresh` to regenerate `.lake/conformance/`.
-/

set_option autoImplicit false

namespace DeanLean.Conformance

-- ════════════════════════════════════════════════════════════
-- § Core types
-- ════════════════════════════════════════════════════════════

/-- How to compare actual vs expected output. -/
inductive CompareMode where
  /-- Exact equality (strings, integers, booleans). -/
  | exact
  /-- Approximate equality within tolerance (floats). -/
  | approx (tolerance : Float)
  /-- Row-set equality (tables — order doesn't matter). -/
  | rowSet
  /-- Normalized string equality (trim whitespace, normalize newlines). -/
  | normalized
  deriving Repr

/-- What kind of reference system this spec targets. -/
inductive ReferenceSystem where
  | r (version : String := "")
  | numpy (version : String := "")
  | postgresql (version : String := "")
  | sqlite
  | commonmark (specVersion : String := "0.31")
  | openssl
  | custom (name : String)
  deriving Repr

/-- A single conformance fixture: input, expected output, and how to compare. -/
structure Fixture where
  /-- Human-readable name for this fixture. -/
  name : String
  /-- The reference system and command that produced the expected output. -/
  reference : ReferenceSystem
  /-- Shell command to reproduce (for documentation / refresh). -/
  command : String
  /-- Comparison mode. -/
  mode : CompareMode
  deriving Repr

-- ════════════════════════════════════════════════════════════
-- § Comparison helpers (pure, used in manifest proofs)
-- ════════════════════════════════════════════════════════════

/-- Approximate equality for floats. -/
def approxEq (a b : Float) (tol : Float := 1e-10) : Bool :=
  (a - b).abs < tol

/-- Approximate equality for float arrays (element-wise). -/
def approxEqArray (a b : Array Float) (tol : Float := 1e-10) : Bool :=
  a.size == b.size &&
  (Array.zipWith a b (fun x y => approxEq x y tol)).all id

/-- Normalized string comparison (trim, collapse whitespace, normalize newlines). -/
def normalizedEq (a b : String) : Bool :=
  let norm (s : String) := s.trim.replace "\r\n" "\n"
  norm a == norm b

/-- Row-set equality for string arrays (order-independent). -/
def rowSetEq (a b : Array String) : Bool :=
  let sa := a.qsort (· < ·)
  let sb := b.qsort (· < ·)
  sa == sb

end DeanLean.Conformance
