-- Header for Cslib.Algorithms.Lean.TimeM (MergeSort)
-- Source: Cslib/Algorithms/Lean/MergeSort/MergeSort.lean (207 lines)
-- This file is NOT compiled — it's a readable specification.

import Cslib.Algorithms.Lean.MergeSort.MergeSort

open Cslib.Algorithms.Lean.TimeM

/-! # MergeSort: verified sorting with proven O(n log n) complexity

  `mergeSort` operates in the `TimeM ℕ` monad, which pairs a return
  value with a comparison count.

  ## Reading the theorems

  ⟪tm⟫       — extract the return value (the sorted list)
  tm.time    — extract the cost (number of comparisons)
  IsSorted l — List.Pairwise (· ≤ ·) l
  l₁ ~ l₂   — l₁ is a permutation of l₂ (List.Perm)

  ## The two results that matter

  mergeSort_correct : IsSorted ⟪mergeSort xs⟫ ∧ ⟪mergeSort xs⟫ ~ xs
  mergeSort_time    : (mergeSort xs).time ≤ n * ⌈log₂ n⌉
-/

variable {α : Type} [LinearOrder α]

-- ════════════════════════════════════════════
-- Correctness
-- ════════════════════════════════════════════

-- Merging two sorted lists produces a sorted list.
ProvenTheorem sorted_merge :
    ∀ {l1 l2 : List α}, IsSorted l1 → IsSorted l2 →
    IsSorted ⟪merge l1 l2⟫

-- mergeSort output is sorted.
ProvenTheorem mergeSort_sorted :
    ∀ (xs : List α), IsSorted ⟪mergeSort xs⟫

-- mergeSort output is a permutation of input.
ProvenTheorem mergeSort_perm :
    ∀ (xs : List α), ⟪mergeSort xs⟫ ~ xs

-- Both combined.
ProvenTheorem mergeSort_correct :
    ∀ (xs : List α), IsSorted ⟪mergeSort xs⟫ ∧ ⟪mergeSort xs⟫ ~ xs

-- ════════════════════════════════════════════
-- Complexity  (cost model: one ✓ per comparison)
-- ════════════════════════════════════════════

-- merge costs at most the total number of elements.
ProvenTheorem merge_time :
    ∀ (xs ys : List α), (merge xs ys).time ≤ xs.length + ys.length

-- mergeSort preserves length.
ProvenTheorem mergeSort_same_length :
    ∀ (xs : List α), ⟪mergeSort xs⟫.length = xs.length

-- The headline: O(n log n) comparisons.
ProvenTheorem mergeSort_time :
    ∀ (xs : List α),
    (mergeSort xs).time ≤ xs.length * Nat.clog 2 xs.length
