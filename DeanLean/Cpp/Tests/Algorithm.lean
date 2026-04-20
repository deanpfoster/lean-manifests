import DeanLean.Cpp.Code.Algorithm
import DeanLean.Cpp.Proofs.Algorithm

namespace Cpp.Algorithm.Tests

/-! # Tests for C++ algorithm formalizations (N4950 §27.7-27.9)

  Executable tests using `#eval` and `assert!`, plus named `_test` definitions
  for use with `TestedConjecture` in the header file.
-/

/-! ## cppMin tests -/

#eval do
  assert! cppMin 3 5 == 3
  assert! cppMin 5 3 == 3
  assert! cppMin 3 3 == 3
  assert! cppMin 0 100 == 0
  assert! cppMin 100 0 == 0
  -- Stability: when equal, returns first argument (both are same value for Nat)
  assert! cppMin 7 7 == 7

/-! ## cppMax tests -/

#eval do
  assert! cppMax 3 5 == 5
  assert! cppMax 5 3 == 5
  assert! cppMax 3 3 == 3
  assert! cppMax 0 100 == 100
  assert! cppMax 100 0 == 100

/-! ## cppClamp tests -/

#eval do
  -- Below range
  assert! cppClamp 2 3 7 == 3
  -- In range
  assert! cppClamp 5 3 7 == 5
  -- Above range
  assert! cppClamp 9 3 7 == 7
  -- At boundaries
  assert! cppClamp 3 3 7 == 3
  assert! cppClamp 7 3 7 == 7
  -- Degenerate range (lo = hi)
  assert! cppClamp 0 5 5 == 5
  assert! cppClamp 5 5 5 == 5
  assert! cppClamp 9 5 5 == 5

/-! ## minElement tests -/

#eval do
  assert! minElement [3, 1, 4, 1, 5, 9, 2, 6] == 1
  assert! minElement [42] == 42
  assert! minElement [5, 4, 3, 2, 1] == 1
  assert! minElement [1, 2, 3, 4, 5] == 1
  assert! minElement [7, 7, 7] == 7

/-! ## maxElement tests -/

#eval do
  assert! maxElement [3, 1, 4, 1, 5, 9, 2, 6] == 9
  assert! maxElement [42] == 42
  assert! maxElement [5, 4, 3, 2, 1] == 5
  assert! maxElement [1, 2, 3, 4, 5] == 5
  assert! maxElement [7, 7, 7] == 7

/-! ## isSorted tests -/

#eval do
  assert! isSorted ([] : List Nat) == true
  assert! isSorted [42] == true
  assert! isSorted [1, 2, 3, 4, 5] == true
  assert! isSorted [1, 1, 2, 2, 3] == true
  assert! isSorted [1, 3, 2, 4] == false
  assert! isSorted [5, 4, 3, 2, 1] == false
  assert! isSorted [1, 2, 3, 2] == false

end Cpp.Algorithm.Tests

/-! ## Named test definitions for TestedConjecture -/

namespace Cpp

/-- Test: `cppMin` is commutative on concrete Nat values. -/
def cppMin_comm_test :=
  show cppMin 3 5 = cppMin 5 3 from rfl

/-- Test: `cppMax` is commutative on concrete Nat values. -/
def cppMax_comm_test :=
  show cppMax 3 5 = cppMax 5 3 from rfl

/-- Test: `cppClamp` keeps value in range on concrete values. -/
def cppClamp_in_range_test :=
  show cppClamp 2 3 7 = 3 ∧ cppClamp 5 3 7 = 5 ∧ cppClamp 9 3 7 = 7 from
    ⟨rfl, rfl, rfl⟩

/-- Test: `isSorted` correctly identifies a sorted list. -/
def isSorted_sorted_test :=
  show isSorted [1, 2, 3, 4, 5] = true from rfl

/-- Test: `isSorted` correctly identifies an unsorted list. -/
def isSorted_unsorted_test :=
  show isSorted [1, 3, 2, 4] = false from rfl

/-- Test: `minElement` finds the minimum in a list. -/
def minElement_finds_min_test :=
  show minElement [3, 1, 4, 1, 5] = 1 from rfl

/-- Test: `maxElement` finds the maximum in a list. -/
def maxElement_finds_max_test :=
  show maxElement [3, 1, 4, 1, 5] = 5 from rfl

/-- Test: `cppMin` self-identity on a concrete value. -/
def cppMin_self_test :=
  show cppMin 42 42 = 42 from rfl

/-- Test: `cppMax` self-identity on a concrete value. -/
def cppMax_self_test :=
  show cppMax 42 42 = 42 from rfl

/-- Test: `cppClamp` at boundary values. -/
def cppClamp_boundary_test :=
  show cppClamp 3 3 7 = 3 ∧ cppClamp 7 3 7 = 7 from ⟨rfl, rfl⟩

/-- Test: `cppMin` is commutative on concrete Nat values (for TestedConjecture). -/
def cppMin_comm_nat_test :=
  show cppMin 3 5 = cppMin 5 3 from rfl

/-- Test: `cppMax` is commutative on concrete Nat values (for TestedConjecture). -/
def cppMax_comm_nat_test :=
  show cppMax 3 5 = cppMax 5 3 from rfl

/-- Test: `cppClamp` in-range on concrete Nat values (for TestedConjecture). -/
def cppClamp_in_range_nat_test :=
  show cppClamp 2 3 7 = 3 ∧ cppClamp 5 3 7 = 5 ∧ cppClamp 9 3 7 = 7 from
    ⟨rfl, rfl, rfl⟩

end Cpp
