import CslibHeaders.Basic
import CslibHeaders.Proofs.Algorithms.Lean.MergeSort.MergeSort

/-! # MergeSort — verified sorting with O(n log n) complexity

  Vocabulary:
    IsSorted l  = List.Pairwise (· ≤ ·) l
    ⟪tm⟫        = tm.ret (return value)
    tm.time     = comparison count
-/

open Cslib.Algorithms.Lean Cslib.Algorithms.Lean.TimeM

-- Correctness
ProvenTheorem mergeSort_sorted  : ∀ {α} [LinearOrder α] (xs : List α), IsSorted ⟪mergeSort xs⟫
ProvenTheorem mergeSort_perm    : ∀ {α} [LinearOrder α] (xs : List α), ⟪mergeSort xs⟫.Perm xs
ProvenTheorem mergeSort_correct : ∀ {α} [LinearOrder α] (xs : List α), IsSorted ⟪mergeSort xs⟫ ∧ ⟪mergeSort xs⟫.Perm xs

-- Complexity
ProvenTheorem merge_time             : ∀ {α} [LinearOrder α] (xs ys : List α), (merge xs ys).time ≤ xs.length + ys.length
ProvenTheorem mergeSort_same_length  : ∀ {α} [LinearOrder α] (xs : List α), ⟪mergeSort xs⟫.length = xs.length
ProvenTheorem mergeSort_time         : ∀ {α} [LinearOrder α] (xs : List α), (mergeSort xs).time ≤ xs.length * Nat.clog 2 xs.length
