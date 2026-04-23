# LambdaCalculus.LocallyNameless.Untyped.FullBeta

Defines full beta-reduction for the locally nameless lambda calculus via congruence closure of the beta rule. Proves congruence lemmas for multi-step reduction.

## Vocabulary

| Name | Kind | Description |
|------|------|-------------|
| `Beta` | inductive | Single beta step: `(abs M).app N ⭢ M ^ N` |
| `FullBeta` | abbrev | `Xi Beta` — congruence closure of beta |

## Theorems

| # | Name | Signature | Visibility |
|---|------|-----------|------------|
| 1 | `step_lc_l` | `M ⭢βᶠ M' → LC M` | PUBLIC |
| 2 | `step_lc_r` | `M ⭢βᶠ M' → LC M'` | PUBLIC |
| 3 | `redex_abs_cong` | `(∀ x ∉ xs, M ^ fvar x ↠βᶠ M' ^ fvar x) → M.abs ↠βᶠ M'.abs` | PUBLIC |
| 4 | `step_not_fv` | `M ⭢βᶠ N → w ∉ M.fv → w ∉ N.fv` | PUBLIC |

## Statistics

- **Theorems/Lemmas**: 15+
- **Lines of code**: 200
- **Authors**: Chris Henson
