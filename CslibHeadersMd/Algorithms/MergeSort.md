# Header: Cslib.Algorithms.Lean.TimeM (MergeSort)

## Module Summary

This module defines `merge` and `mergeSort` algorithms that operate within the `TimeM` monad,
producing both a sorted list and a count of comparisons performed. The module proves two main
results: functional correctness (the output is a sorted permutation of the input) and time
complexity (the number of comparisons is at most `n * ceil(log2 n)`). All definitions and theorems
live in the `Cslib.Algorithms.Lean.TimeM` namespace.

## Dependencies

```
public import Cslib.Algorithms.Lean.TimeM          -- TimeM monad, tick, ret/time projections
public import Mathlib.Data.Nat.Cast.Order.Ring      -- ordered semiring coercions for Nat
public import Mathlib.Data.Nat.Lattice              -- Nat lattice operations
public import Mathlib.Data.Nat.Log                  -- Nat.clog (ceiling log)
```

## Vocabulary

| Name | Kind | Description |
|------|------|-------------|
| `TimeM T a` | structure | Monad pairing a return value `a` with an accumulated cost of type `T`. Defined in `TimeM.lean`. |
| `⟪tm⟫` | notation | Extracts the pure return value (`TimeM.ret`) from a `TimeM` computation. |
| `✓` | macro | Adds one tick of cost inside a `do` block (sugar for `TimeM.tick 1`). |
| `IsSorted l` | abbrev | `List.Pairwise (. <= .) l` -- the list is non-decreasingly ordered. |
| `MinOfList x l` | abbrev | `forall b in l, x <= b` -- `x` is a lower bound of every element of `l`. |
| `T n` | abbrev | The upper-bound function `n * Nat.clog 2 n` (i.e. `n * ceil(log2 n)`). |
| `timeMergeSortRec n` | def | The exact recurrence counting comparisons: `T(0)=0, T(1)=0, T(n)=T(n/2)+T(ceil(n/2))+n`. |
| `Perm` / `~` | Mathlib | `l1 ~ l2` means `l1` is a permutation of `l2`. |
| `Nat.clog b n` | Mathlib | Ceiling logarithm base `b` of `n`. |

## Definitions

```
def merge : List a -> List a -> TimeM Nat (List a)
```
Merges two sorted lists into one, charging one tick per comparison (`x <= y`).

```
def mergeSort (xs : List a) : TimeM Nat (List a)
```
Top-down merge sort. Splits at `xs.length / 2`, recursively sorts both halves, then merges.

```
def timeMergeSortRec : Nat -> Nat
  | 0     => 0
  | 1     => 0
  | n+2   => timeMergeSortRec (n/2) + timeMergeSortRec ((n-1)/2 + 1) + n
```
Closed-form recurrence for the number of comparisons performed by `mergeSort`.

```
abbrev IsSorted (l : List a) : Prop := List.Pairwise (. <= .) l

abbrev MinOfList (x : a) (l : List a) : Prop := forall b in l, x <= b

abbrev T (n : Nat) : Nat := n * Nat.clog 2 n
```

## Theorem Listing

### CORRECTNESS (functional behavior)

```
theorem ret_merge (xs ys : List a) :
    ⟪merge xs ys⟫ = xs.merge ys
```
The return value of timed `merge` equals the pure `List.merge` from Mathlib.
Attributes: `@[simp, grind =]`.

```
theorem mem_either_merge (xs ys : List a) (z : a) (hz : z in ⟪merge xs ys⟫) :
    z in xs \/ z in ys
```
Every element in the merge output came from one of the two input lists.
Attribute: `@[grind ->]`.

```
theorem min_all_merge (x : a) (xs ys : List a)
    (hxs : MinOfList x xs) (hys : MinOfList x ys) :
    MinOfList x ⟪merge xs ys⟫
```
If `x` is a lower bound of both input lists, it is a lower bound of their merge.

```
theorem sorted_merge {l1 l2 : List a}
    (hxs : IsSorted l1) (hys : IsSorted l2) :
    IsSorted ⟪merge l1 l2⟫
```
Merging two sorted lists produces a sorted list.

```
theorem mergeSort_sorted (xs : List a) :
    IsSorted ⟪mergeSort xs⟫
```
The output of `mergeSort` is sorted.

```
lemma merge_perm (l1 l2 : List a) :
    ⟪merge l1 l2⟫ ~ l1 ++ l2
```
The merge output is a permutation of the concatenation of its inputs.

```
theorem mergeSort_perm (xs : List a) :
    ⟪mergeSort xs⟫ ~ xs
```
The output of `mergeSort` is a permutation of the input.

```
theorem mergeSort_correct (xs : List a) :
    IsSorted ⟪mergeSort xs⟫ /\ ⟪mergeSort xs⟫ ~ xs
```
**Main correctness theorem.** `mergeSort` produces a sorted permutation of its input.

### COMPLEXITY (time/space bounds)

```
theorem merge_ret_length_eq_sum (xs ys : List a) :
    ⟪merge xs ys⟫.length = xs.length + ys.length
```
The merged list has length equal to the sum of the input lengths.

```
theorem mergeSort_same_length (xs : List a) :
    ⟪mergeSort xs⟫.length = xs.length
```
`mergeSort` preserves list length. Attribute: `@[simp]`.

```
theorem merge_time (xs ys : List a) :
    (merge xs ys).time <= xs.length + ys.length
```
The number of comparisons in `merge` is at most the total number of elements. Attribute: `@[simp]`.

```
theorem mergeSort_time_le (xs : List a) :
    (mergeSort xs).time <= timeMergeSortRec xs.length
```
The comparison count of `mergeSort` is bounded by the recurrence `timeMergeSortRec`.

```
theorem timeMergeSortRec_le (n : Nat) :
    timeMergeSortRec n <= T n
```
The recurrence solves to at most `n * ceil(log2 n)`.

```
theorem mergeSort_time (xs : List a) :
    let n := xs.length
    (mergeSort xs).time <= n * Nat.clog 2 n
```
**Main complexity theorem.** The total number of comparisons in `mergeSort` is at most
`n * ceil(log2 n)`.

### HELPER (internal lemmas, not part of the public API)

```
lemma clog2_half_le (n : Nat) (h : n > 1) :
    Nat.clog 2 ((n + 1) / 2) <= Nat.clog 2 n - 1
```
Ceiling log of the upper half is at most one less than ceiling log of `n`.
Attribute: `@[grind ->]`.

```
lemma clog2_floor_half_le (n : Nat) (h : n > 1) :
    Nat.clog 2 (n / 2) <= Nat.clog 2 n - 1
```
Ceiling log of the lower half is at most one less than ceiling log of `n`.
Attribute: `@[grind ->]`.

```
private lemma some_algebra (n : Nat) :
    (n / 2 + 1) * Nat.clog 2 (n / 2 + 1)
      + ((n + 1) / 2 + 1) * Nat.clog 2 ((n + 1) / 2 + 1)
      + (n + 2)
    <= (n + 2) * Nat.clog 2 (n + 2)
```
Algebraic inequality used to close the inductive step of `timeMergeSortRec_le`.

## Statistics

| Metric | Count |
|--------|-------|
| Lines (MergeSort.lean) | 207 |
| Definitions (`def`) | 3 (`merge`, `mergeSort`, `timeMergeSortRec`) |
| Abbreviations (`abbrev`) | 3 (`IsSorted`, `MinOfList`, `T`) |
| Theorems / lemmas | 14 total |
| -- Correctness | 7 (`ret_merge`, `mem_either_merge`, `min_all_merge`, `sorted_merge`, `mergeSort_sorted`, `merge_perm`, `mergeSort_perm`, `mergeSort_correct`) |
| -- Complexity | 5 (`merge_ret_length_eq_sum`, `mergeSort_same_length`, `merge_time`, `mergeSort_time_le`, `timeMergeSortRec_le`, `mergeSort_time`) |
| -- Helper | 3 (`clog2_half_le`, `clog2_floor_half_le`, `some_algebra`) |

Note: `mergeSort_correct` bundles `mergeSort_sorted` and `mergeSort_perm`.
`mergeSort_time` follows directly from `mergeSort_time_le` and `timeMergeSortRec_le`.

## Implicit Context

All definitions and theorems carry the implicit variables:
```
variable {a : Type} [LinearOrder a]
```
The `LinearOrder` instance provides decidable `<=` used for comparisons inside `merge`.
