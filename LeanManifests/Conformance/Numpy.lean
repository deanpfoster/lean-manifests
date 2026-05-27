import LeanManifests.Conformance

/-! # LeanManifests.Conformance.Numpy — conformance harness for numpy/scipy

Shape: arrays/matrices in, arrays/scalars out.
Reference: `python3 -c 'import numpy as np; ...'`
Comparison: approximate equality (numpy uses LAPACK under the hood;
            floating-point path may differ from our pure implementation).

## Shapes this covers

- **numpy.linalg**: matmul, svd, eig, det, inv, solve
- **numpy.fft**: fft, ifft, rfft
- **scipy.stats**: norm.cdf, t.cdf, chi2.cdf (distribution functions)
- **scipy.optimize**: minimize (iterative — wider tolerance)

## Golden fixture example: matrix multiply

Demonstrates the pattern for array-in, array-out conformance.
-/

set_option autoImplicit false

namespace LeanManifests.Conformance.Numpy
open LeanManifests.Conformance

-- ════════════════════════════════════════════════════════════
-- § Numpy-specific helpers
-- ════════════════════════════════════════════════════════════

/-- Format a Float array as numpy array syntax. -/
def npArray (xs : Array Float) : String :=
  "np.array([" ++ String.intercalate "," (xs.toList.map toString) ++ "])"

/-- Build a python3 -c command string. -/
def python (code : String) : String :=
  "python3 -c 'import numpy as np; " ++ code ++ "'"

/-- Standard fixture metadata for a numpy conformance check. -/
def npFixture (name : String) (code : String) (tol : Float := 1e-10) : Fixture :=
  { name
    reference := .numpy
    command := python code
    mode := .approx tol }

-- ════════════════════════════════════════════════════════════
-- § Golden fixture: dot product
-- ════════════════════════════════════════════════════════════

/-- Input vectors. -/
private def a : Array Float := #[1.0, 2.0, 3.0]
private def b : Array Float := #[4.0, 5.0, 6.0]

/-- Expected output from numpy:
    ```
    >>> import numpy as np
    >>> np.dot([1,2,3], [4,5,6])
    32.0
    ```
-/
private def expected_dot : Float := 32.0

def dot_golden : Fixture := npFixture "numpy_dot"
  "print(np.dot([1,2,3], [4,5,6]))"

-- ════════════════════════════════════════════════════════════
-- § Golden fixture: standard deviation
-- ════════════════════════════════════════════════════════════

private def xs : Array Float := #[2.0, 4.0, 4.0, 4.0, 5.0, 5.0, 7.0, 9.0]

/-- Expected from numpy (population std, ddof=0):
    ```
    >>> np.std([2,4,4,4,5,5,7,9])
    2.0
    ```
-/
private def expected_std_pop : Float := 2.0

/-- Expected from numpy (sample std, ddof=1):
    ```
    >>> np.std([2,4,4,4,5,5,7,9], ddof=1)
    2.138...
    ```
    Note: R's sd() uses ddof=1 by default. numpy's std() uses ddof=0.
    This is a common source of conformance mismatches between R and numpy.
-/
private def expected_std_sample : Float := 2.1380899352993952

def std_golden : Fixture := npFixture "numpy_std"
  "print(np.std([2,4,4,4,5,5,7,9], ddof=1))"

-- ════════════════════════════════════════════════════════════
-- § Spec template
-- ════════════════════════════════════════════════════════════

/-- A numpy conformance spec for bulk generation. -/
structure NumpySpec where
  name : String
  /-- Python code template. `{a}` and `{b}` are substituted. -/
  pyCodeTemplate : String
  count : Nat := 100
  tolerance : Float := 1e-10
  deriving Repr

/-- Example spec: test dot product on random vectors. -/
def dot_spec : NumpySpec :=
  { name := "numpy_dot"
    pyCodeTemplate := "a={a}; b={b}; print(np.dot(a,b))"
    count := 100 }

/-- Example spec: test matrix multiply on random matrices. -/
def matmul_spec : NumpySpec :=
  { name := "numpy_matmul"
    pyCodeTemplate := "A=np.array({A}).reshape({m},{k}); B=np.array({B}).reshape({k},{n}); print(list((A@B).flatten()))"
    count := 50
    tolerance := 1e-8 }

end LeanManifests.Conformance.Numpy
