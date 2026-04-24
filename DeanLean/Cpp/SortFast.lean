import DeanLean.Cpp.Defs.Sort

set_option levelized.fast true

/-! # Sort (fast mode) — axioms only, no proof dependencies -/

namespace Cpp.Sort

ProvenTheorem insertionSort_sorted : ∀ (l : List Nat), IsSorted (insertionSort l)
ProvenTheorem insertionSort_perm : ∀ (l : List Nat), IsPermutation l (insertionSort l)
ProvenTheorem insertionSort_length : ∀ (l : List Nat), (insertionSort l).length = l.length
ProvenTheorem isSorted_iff_IsSorted : ∀ (l : List Nat), isSorted l = true ↔ IsSorted l

end Cpp.Sort
