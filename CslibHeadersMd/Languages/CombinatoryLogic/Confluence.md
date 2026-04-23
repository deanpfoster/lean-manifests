# CombinatoryLogic.Confluence

Proves the Church-Rosser theorem for SKI combinatory logic via the Tait-Martin-Lof method using parallel reduction.

## Vocabulary

| Name | Kind | Description |
|------|------|-------------|
| `ParallelReduction` | inductive | Parallel reduction allowing simultaneous redex contraction |

## Theorems

| # | Name | Signature | Visibility |
|---|------|-----------|------------|
| 1 | `mRed_of_parallelReduction` | `(a ⭢ₚ a') → a ↠ a'` | PUBLIC |
| 2 | `parallelReduction_of_red` | `(a ⭢ a') → a ⭢ₚ a'` | PUBLIC |
| 3 | `reflTransGen_parallelReduction_mRed` | `ReflTransGen ParallelReduction = ReflTransGen Red` | PUBLIC |
| 4 | `parallelReduction_diamond` | `Diamond ParallelReduction` | PUBLIC |
| 5 | `mJoin_red_equivalence` | `Equivalence (MJoin Red)` | PUBLIC |
| 6 | `MRed.diamond` | `Confluent Red` | PUBLIC |

## Statistics

- **Theorems/Lemmas**: 6 major + 6 irreducibility lemmas
- **Lines of code**: 226
- **Authors**: Thomas Waring
