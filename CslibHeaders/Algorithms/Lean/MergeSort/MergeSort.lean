import CslibHeaders.Basic
import Cslib.Algorithms.Lean.MergeSort.MergeSort

/-! # MergeSort: verified sorting with proven O(n log n) complexity

  ## Vocabulary
  - `⟪tm⟫` — extract return value from TimeM computation
  - `tm.time` — extract cost (comparison count)
  - `IsSorted l` — `List.Pairwise (· ≤ ·) l`
  - `l₁ ~ l₂` — `l₁` is a permutation of `l₂`
  - `Nat.clog 2 n` — ⌈log₂ n⌉

  ## The two results that matter
  - `mergeSort_correct`: sorted permutation of input
  - `mergeSort_time`: at most `n * ⌈log₂ n⌉` comparisons
-/

open Cslib.Algorithms.Lean
open Cslib.Algorithms.Lean.TimeM

-- ════════════════════════════════════════════
-- Correctness
-- ════════════════════════════════════════════

ExternalTheorem sorted_merge
  := @Cslib.Algorithms.Lean.TimeM.sorted_merge
  : ∀ {α : Type} [LinearOrder α] {l1 l2 : List α},
    IsSorted l1 → IsSorted l2 → IsSorted ⟪merge l1 l2⟫

ExternalTheorem mergeSort_sorted
  := @Cslib.Algorithms.Lean.TimeM.mergeSort_sorted
  : ∀ {α : Type} [LinearOrder α] (xs : List α), IsSorted ⟪mergeSort xs⟫

ExternalTheorem mergeSort_perm
  := @Cslib.Algorithms.Lean.TimeM.mergeSort_perm
  : ∀ {α : Type} [LinearOrder α] (xs : List α), ⟪mergeSort xs⟫.Perm xs

ExternalTheorem mergeSort_correct
  := @Cslib.Algorithms.Lean.TimeM.mergeSort_correct
  : ∀ {α : Type} [LinearOrder α] (xs : List α),
    IsSorted ⟪mergeSort xs⟫ ∧ ⟪mergeSort xs⟫.Perm xs

-- ════════════════════════════════════════════
-- Complexity (cost model: one ✓ per comparison)
-- ════════════════════════════════════════════

ExternalTheorem merge_time
  := @Cslib.Algorithms.Lean.TimeM.merge_time
  : ∀ {α : Type} [LinearOrder α] (xs ys : List α),
    (merge xs ys).time ≤ xs.length + ys.length

ExternalTheorem mergeSort_same_length
  := @Cslib.Algorithms.Lean.TimeM.mergeSort_same_length
  : ∀ {α : Type} [LinearOrder α] (xs : List α),
    ⟪mergeSort xs⟫.length = xs.length

ExternalTheorem mergeSort_time
  := @Cslib.Algorithms.Lean.TimeM.mergeSort_time
  : ∀ {α : Type} [LinearOrder α] (xs : List α),
    (mergeSort xs).time ≤ xs.length * Nat.clog 2 xs.length
