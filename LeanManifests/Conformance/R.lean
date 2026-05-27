import LeanManifests.Conformance

/-! # LeanManifests.Conformance.R — conformance harness for R (CRAN)

Shape: numeric arrays in, numeric scalars/arrays out.
Reference: `Rscript -e '...'`
Comparison: approximate equality (Float arithmetic may differ in last ULP).

## Example: lm() conformance

The golden fixture below demonstrates the pattern. A consumer library
(e.g. lean-stats) would have many of these, one per R function.

## Spec shape for bulk generation

A conformance spec for R looks like:

```
-- How to generate random inputs
inputGen seed n := randomFloats seed n (-100, 100)

-- The R command template (inputs substituted in)
rCommand xs ys := s!"fit <- lm(c({ys}) ~ c({xs})); cat(coef(fit)[2])"

-- What our Lean function computes
leanFn xs ys := getSlope xs ys

-- Tolerance for comparison
tolerance := 1e-10
```

The `lake run conformance:refresh` script instantiates this with many
seeds, runs R, and writes the expected values to `.lake/conformance/R/`.
-/

set_option autoImplicit false

namespace LeanManifests.Conformance.R
open LeanManifests.Conformance

-- ════════════════════════════════════════════════════════════
-- § R-specific helpers
-- ════════════════════════════════════════════════════════════

/-- Format a Float array as R's c() syntax. -/
def rVector (xs : Array Float) : String :=
  "c(" ++ String.intercalate "," (xs.toList.map toString) ++ ")"

/-- Build an Rscript -e command string. -/
def rscript (code : String) : String :=
  "Rscript --vanilla -e '" ++ code ++ "'"

/-- Standard fixture metadata for an R conformance check. -/
def rFixture (name : String) (code : String) (tol : Float := 1e-10) : Fixture :=
  { name
    reference := .r
    command := rscript code
    mode := .approx tol }

-- ════════════════════════════════════════════════════════════
-- § Golden fixture: lm(y ~ x) on perfect linear data
-- ════════════════════════════════════════════════════════════

/-- The input data. -/
private def xs : Array Float := #[1.0, 2.0, 3.0, 4.0, 5.0]
private def ys : Array Float := #[3.0, 5.0, 7.0, 9.0, 11.0]

/-- Expected output from R:
    ```
    > fit <- lm(c(3,5,7,9,11) ~ c(1,2,3,4,5))
    > coef(fit)
    (Intercept)           x
              1           2
    > summary(fit)$r.squared
    [1] 1
    ```
-/
private def expected_slope : Float := 2.0
private def expected_intercept : Float := 1.0
private def expected_r2 : Float := 1.0

/-- Fixture metadata (documents how to reproduce). -/
def lm_golden : Fixture := rFixture "lm_perfect_linear"
  "fit <- lm(c(3,5,7,9,11) ~ c(1,2,3,4,5)); cat(coef(fit)[2], coef(fit)[1], summary(fit)$r.squared)"

-- The actual conformance claims live in the consumer library (lean-stats),
-- not here. This module provides the INFRASTRUCTURE and the EXAMPLE of
-- how to structure them. A consumer would write:
--
--   import LeanManifests.Conformance.R
--
--   ProvenTheorem conforms_r_lm_slope :
--     approxEq (getSlope xs ys).get! expected_slope = true
--
-- That's a ProvenTheorem because native_decide can evaluate it.

-- ════════════════════════════════════════════════════════════
-- § Spec template (for bulk generation)
-- ════════════════════════════════════════════════════════════

/-- A conformance spec describes how to generate many fixtures.
    The `lake run conformance:refresh` script reads these and
    produces `.lake/conformance/R/<name>.generated.lean`. -/
structure RSpec where
  /-- Unique name for this spec. -/
  name : String
  /-- R code template. `{xs}` and `{ys}` are substituted with generated data. -/
  rCodeTemplate : String
  /-- Number of fixtures to generate. -/
  count : Nat := 100
  /-- Tolerance for approximate comparison. -/
  tolerance : Float := 1e-10
  deriving Repr

/-- Example spec: test lm() on random data. -/
def lm_spec : RSpec :=
  { name := "r_lm"
    rCodeTemplate := "x <- c({xs}); y <- c({ys}); fit <- lm(y ~ x); cat(coef(fit)[2])"
    count := 50
    tolerance := 1e-10 }

/-- Example spec: test cor() on random data. -/
def cor_spec : RSpec :=
  { name := "r_cor"
    rCodeTemplate := "x <- c({xs}); y <- c({ys}); cat(cor(x, y))"
    count := 50
    tolerance := 1e-10 }

/-- Example spec: test t.test() on random data. -/
def ttest_spec : RSpec :=
  { name := "r_ttest"
    rCodeTemplate := "x <- c({xs}); cat(t.test(x)$statistic)"
    count := 50
    tolerance := 1e-8 }

end LeanManifests.Conformance.R
