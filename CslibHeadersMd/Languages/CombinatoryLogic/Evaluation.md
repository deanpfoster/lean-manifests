# CombinatoryLogic.Evaluation

Formalises normal forms, an evaluation function, unique normal forms, and Rice's theorem for the SKI calculus.

## Vocabulary

| Name | Kind | Description |
|------|------|-------------|
| `RedexFree` | def | Predicate: a term has no reducible sub-terms |
| `evalStep` | def | One-step normal-order reduction as a function |

## Theorems

| # | Name | Signature | Visibility |
|---|------|-----------|------------|
| 1 | `evalStep_right_correct` | `x.evalStep = Sum.inr y → x ⭢ y` | PUBLIC |
| 2 | `redexFree_iff` | `x.RedexFree ↔ Normal Red x` | PUBLIC |
| 3 | `redexFree_iff_mred_eq` | `x.RedexFree ↔ ∀ y, (x ↠ y) ↔ x = y` | PUBLIC |
| 4 | `unique_normal_form` | `(x ↠ y) → (x ↠ z) → y.RedexFree → z.RedexFree → y = z` | PUBLIC |
| 5 | `isBool_injective` | `IsBool u x → IsBool v y → MJoin Red x y → u = v` | PUBLIC |
| 6 | `isChurch_injective` | `IsChurch n x → IsChurch m y → MJoin Red x y → n = m` | PUBLIC |
| 7 | `rice` | `(∀ x, P ⬝ x ↠ TT ∨ P ⬝ x ↠ FF) → (∃ x, P ⬝ x ↠ TT) → (∃ x, P ⬝ x ↠ FF) → False` | PUBLIC |
| 8 | `rice'` | `(∀ x, P ⬝ x ↠ TT ∨ P ⬝ x ↠ FF) → (∀ x, P ⬝ x ↠ TT) ∨ (∀ x, P ⬝ x ↠ FF)` | PUBLIC |

## Statistics

- **Theorems/Lemmas**: 8 major
- **Lines of code**: 312
- **Authors**: Thomas Waring
