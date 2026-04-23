# CombinatoryLogic.Defs

Defines the syntax and operational semantics (single-step and multi-step reduction) of SKI combinatory logic.

## Vocabulary

| Name | Kind | Description |
|------|------|-------------|
| `SKI` | inductive | SKI expressions: S, K, I, and application |
| `SKI.Red` | inductive | Single-step reduction (5 rules: red_S, red_K, red_I, red_head, red_tail) |
| `SKI.size` | def | Number of combinators in a term |
| `SKI.applyList` | def | Apply a term to a list of terms |

## Theorems

| # | Name | Signature | Visibility |
|---|------|-----------|------------|
| 1 | `applyList_concat` | `f.applyList (ys ++ [z]) = f.applyList ys ⬝ z` | PUBLIC |
| 2 | `Red.ne` | `(x ⭢ y) → x ≠ y` | PUBLIC |
| 3 | `MRed.S` | `(S ⬝ x ⬝ y ⬝ z) ↠ (x ⬝ z ⬝ (y ⬝ z))` | PUBLIC |
| 4 | `MRed.K` | `(K ⬝ x ⬝ y) ↠ x` | PUBLIC |
| 5 | `MRed.I` | `(I ⬝ x) ↠ x` | PUBLIC |
| 6 | `MRed.head` | `(b : SKI) → (a ↠ a') → (a ⬝ b) ↠ (a' ⬝ b)` | PUBLIC |
| 7 | `MRed.tail` | `(a : SKI) → (b ↠ b') → (a ⬝ b) ↠ (a ⬝ b')` | PUBLIC |
| 8 | `parallel_mRed` | `(a ↠ a') → (b ↠ b') → (a ⬝ b) ↠ (a' ⬝ b')` | PUBLIC |
| 9 | `parallel_red` | `(a ⭢ a') → (b ⭢ b') → (a ⬝ b) ↠ (a' ⬝ b')` | PUBLIC |
| 10 | `mJoin_red_head` | `MJoin Red x x' → MJoin Red (x ⬝ y) (x' ⬝ y)` | PUBLIC |
| 11 | `mJoin_red_tail` | `MJoin Red y y' → MJoin Red (x ⬝ y) (x ⬝ y')` | PUBLIC |

## Statistics

- **Theorems/Lemmas**: 11
- **Definitions**: 4
- **Lines of code**: 124
- **Authors**: Thomas Waring
