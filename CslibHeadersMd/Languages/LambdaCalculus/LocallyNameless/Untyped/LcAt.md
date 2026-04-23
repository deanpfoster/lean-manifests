# LambdaCalculus.LocallyNameless.Untyped.LcAt

Alternative definition of local closure via `LcAt k M` (all bound indices < k). Proves equivalence with `LC` when k = 0.

## Vocabulary

| Name | Kind | Description |
|------|------|-------------|
| `LcAt` | def | All bound indices in M are less than k |
| `depth` | def | Maximum nesting depth of lambdas enclosing variables |

## Theorems

| # | Name | Signature | Visibility |
|---|------|-----------|------------|
| 1 | `lcAt_iff_LC` | `LcAt 0 M ↔ M.LC` | PUBLIC |
| 2 | `open_abs_lc` | `LC (M ^ N) → LC M.abs` | PUBLIC |

## Statistics

- **Theorems/Lemmas**: 2 major + auxiliary
- **Lines of code**: 98
- **Authors**: Elimia (Sehun Kim)
