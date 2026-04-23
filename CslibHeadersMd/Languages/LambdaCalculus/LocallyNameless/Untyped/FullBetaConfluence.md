# LambdaCalculus.LocallyNameless.Untyped.FullBetaConfluence

Proves confluence (Church-Rosser) for full beta-reduction via parallel reduction and the diamond property.

## Vocabulary

| Name | Kind | Description |
|------|------|-------------|
| `Parallel` | inductive | Parallel beta-reduction |

## Theorems

| # | Name | Signature | Visibility |
|---|------|-----------|------------|
| 1 | `parachain_iff_redex` | `M ↠ₚ N ↔ M ↠βᶠ N` | PUBLIC |
| 2 | `para_diamond` | `Diamond Parallel` | PUBLIC |
| 3 | `para_confluence` | `Confluent Parallel` | PUBLIC |
| 4 | `confluence_beta` | `Confluent FullBeta` | PUBLIC |

## Statistics

- **Theorems/Lemmas**: 4 major + many auxiliary
- **Lines of code**: 213
- **Authors**: Chris Henson
