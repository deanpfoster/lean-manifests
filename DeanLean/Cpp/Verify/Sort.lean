import DeanLean.Basic
import DeanLean.Cpp.Defs.Sort
import DeanLean.Cpp.Proofs.Sort

/-! # Verification: Sort — confirms fast-mode axioms match real proofs -/

open Cpp.Sort

VerifyAxiom insertionSort_sorted : ∀ (l : List Nat), IsSorted (insertionSort l)
VerifyAxiom insertionSort_perm : ∀ (l : List Nat), IsPermutation l (insertionSort l)
VerifyAxiom insertionSort_length : ∀ (l : List Nat), (insertionSort l).length = l.length
VerifyAxiom isSorted_iff_IsSorted : ∀ (l : List Nat), isSorted l = true ↔ IsSorted l
