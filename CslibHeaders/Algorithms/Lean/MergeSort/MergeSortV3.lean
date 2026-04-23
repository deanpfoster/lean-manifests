import CslibHeaders.Basic
import CslibHeaders.Defs.Algorithms.Lean.MergeSort.MergeSort
import CslibHeaders.Proofs.Algorithms.Lean.MergeSort.MergeSort

/-! # MergeSort — verified sorting with O(n log n) complexity

  Definitions are in Defs/MergeSort.lean:
    TimeM T α  — monad pairing return value with cost
    IsSorted l — List.Pairwise (· ≤ ·) l
    mergeSort  — merge sort returning TimeM ℕ (List α)

  Read this file for WHAT is true.
  Read Defs/ for WHAT the words mean.
  Never need to open Code or Proofs.
-/

open Cslib.Algorithms.Lean.TimeM

-- Correctness
ProvenTheorem mergeSort_sorted  : ∀ {α} [LinearOrder α] (xs : List α), IsSorted ⟪mergeSort xs⟫
ProvenTheorem mergeSort_perm    : ∀ {α} [LinearOrder α] (xs : List α), ⟪mergeSort xs⟫.Perm xs
ProvenTheorem mergeSort_correct : ∀ {α} [LinearOrder α] (xs : List α), IsSorted ⟪mergeSort xs⟫ ∧ ⟪mergeSort xs⟫.Perm xs

-- Complexity (cost model: one tick per comparison)
ProvenTheorem merge_time            : ∀ {α} [LinearOrder α] (xs ys : List α), (merge xs ys).time ≤ xs.length + ys.length
ProvenTheorem mergeSort_same_length : ∀ {α} [LinearOrder α] (xs : List α), ⟪mergeSort xs⟫.length = xs.length
ProvenTheorem mergeSort_time        : ∀ {α} [LinearOrder α] (xs : List α), (mergeSort xs).time ≤ xs.length * Nat.clog 2 xs.length
