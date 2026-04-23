# Algorithms.Lean.MergeSort.MergeSort

Verified merge sort with time complexity analysis. Implements merge and mergeSort in the TimeM monad, proves functional correctness (sorted + permutation) and that the number of comparisons is at most `n * ceil(log2 n)`.

## Vocabulary

| Name | Kind | Description |
|------|------|-------------|
| `merge` | def | Merge two sorted lists, counting comparisons |
| `mergeSort` | def | Merge sort in TimeM monad |
| `IsSorted` | abbrev | `List.Pairwise (· ≤ ·)` |
| `timeMergeSortRec` | def | Recurrence relation for merge sort time |
| `T` | abbrev | `n * clog 2 n` — upper bound function |

## Theorems

| # | Name | Signature | Visibility |
|---|------|-----------|------------|
| 1 | `ret_merge` | `⟪merge xs ys⟫ = xs.merge ys` | PUBLIC |
| 2 | `mergeSort_sorted` | `IsSorted ⟪mergeSort xs⟫` | PUBLIC |
| 3 | `mergeSort_perm` | `⟪mergeSort xs⟫ ~ xs` | PUBLIC |
| 4 | `mergeSort_correct` | `IsSorted ⟪mergeSort xs⟫ ∧ ⟪mergeSort xs⟫ ~ xs` | PUBLIC |
| 5 | `timeMergeSortRec_le` | `timeMergeSortRec n ≤ T n` | PUBLIC |
| 6 | `mergeSort_time` | `(mergeSort xs).time ≤ n * clog 2 n` | PUBLIC |

## Statistics

- **Theorems/Lemmas**: 6 major
- **Lines of code**: 208
- **Authors**: Sorrachai Yingchareonthawornhcai
