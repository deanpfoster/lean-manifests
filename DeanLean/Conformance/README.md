# DeanLean.Conformance — testing against reference systems

When your Lean implementation is meant to match an external system
(R, numpy, PostgreSQL, CommonMark, etc.), this framework provides
the structure for doing so without breaking library purity.

## The problem

Your library is pure — no IO. But "correct" means "matches R" or
"matches the CommonMark spec." How do you test that?

## The solution: three layers

```
Committed (always compiles, no external deps):
  Conformance/R/Lm.lean           ← ONE golden fixture (ProvenTheorem)

Committed (recipe, not results):
  Conformance/R/Lm.spec.lean      ← how to generate 50+ bulk fixtures

Generated (gitignored, needs reference system installed):
  .lake/conformance/R/r_lm_001.lean  ← machine-produced ProvenTheorem
  .lake/conformance/R/r_lm_002.lean
  ...
```

1. **Golden fixture** — a single hand-verified example. Compiles
   anywhere. This is your CI baseline.

2. **Conformance spec** — a recipe describing how to generate many
   fixtures by running the reference system. This is a program that
   produces tests, not the tests themselves.

3. **Generated fixtures** — produced by `lake run conformance:refresh`.
   Requires the reference system (R, Python, psql) to be installed.
   Gitignored. Ephemeral like build artifacts.

## The four reference system shapes

| Shape | Systems | Input → Output | Comparison |
|-------|---------|---------------|------------|
| **Numeric** | R, numpy, MATLAB | `Array Float → Float` | `approxEq` within ε |
| **Relational** | PostgreSQL, SQLite, DuckDB | `Table → Table` | `rowSetEq` (unordered) |
| **Spec-fixture** | CommonMark, RFC, Unicode | `String → String` | `normalizedEq` or exact |
| **Binary** | OpenSSL, libsodium | `ByteArray → ByteArray` | exact hex match |

Each shape has its own module with helpers and example specs.

## Quick start

### 1. Write a golden fixture

```lean
import DeanLean.Conformance.R
import MyLib.Regression
open DeanLean.Conformance

-- The input (same data you'd give R)
private def xs := #[1.0, 2.0, 3.0, 4.0, 5.0]
private def ys := #[3.0, 5.0, 7.0, 9.0, 11.0]

-- Expected from R: lm(c(3,5,7,9,11) ~ c(1,2,3,4,5))$coef[2] = 2.0
private def expected_slope : Float := 2.0

-- Prove our implementation matches
theorem conforms_r_lm_slope_proof :
  approxEq (getSlope xs ys).get! expected_slope = true := by native_decide

ProvenTheorem conforms_r_lm_slope :
  approxEq (getSlope xs ys).get! expected_slope = true
```

This compiles without R installed. It's a `ProvenTheorem` because
`native_decide` evaluates the comparison at compile time.

### 2. Write a conformance spec (for bulk generation)

```lean
import DeanLean.Conformance.R

def my_lm_spec : DeanLean.Conformance.R.RSpec :=
  { name := "my_lm"
    rCodeTemplate := "x <- c({xs}); y <- c({ys}); fit <- lm(y ~ x); cat(coef(fit)[2])"
    count := 50
    tolerance := 1e-10 }
```

### 3. Run the refresh (needs R installed)

```bash
lake run conformance:refresh
```

This generates 50 `.lean` files in `.lake/conformance/R/my_lm_*.lean`,
each containing a `ProvenTheorem` that our implementation matches R
on randomly generated data.

## Comparison helpers

All in `DeanLean.Conformance`:

- `approxEq (a b : Float) (tol := 1e-10) : Bool` — float comparison
- `approxEqArray (a b : Array Float) (tol := 1e-10) : Bool` — element-wise
- `normalizedEq (a b : String) : Bool` — trim + normalize newlines
- `rowSetEq (a b : Array String) : Bool` — order-independent row comparison

## Why not just use `sorry`?

The golden fixture is a real `ProvenTheorem` — the kernel verifies it.
If your implementation changes and breaks conformance, the build fails.
No `sorry`, no trust-me. The only assumption is the `DecidableEq Float`
instance (which uses bit-level comparison, sound for non-NaN literals).

## File index

| File | Purpose |
|------|---------|
| `Conformance.lean` | Core types, comparison helpers |
| `Conformance/R.lean` | R/CRAN harness, `RSpec`, golden `lm()` example |
| `Conformance/Numpy.lean` | numpy/scipy harness, `NumpySpec`, golden `dot`/`std` examples |
| `Conformance/Sql.lean` | PostgreSQL/SQLite harness, `SqlSpec`, golden `GROUP BY`/`JOIN` examples |
| `Conformance/Spec.lean` | Spec-fixture harness, `SpecFileSpec`, golden CommonMark examples |
| `Conformance/Script.lean` | Lake script support: random generation, file templates |
