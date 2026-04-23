# LambdaCalculus.LocallyNameless.Untyped.StrongNorm

Defines strong normalization (SN) and neutral terms for untyped beta-reduction. Proves that neutral terms are SN and provides the key lemma for the STLC strong normalization proof.

## Vocabulary

| Name | Kind | Description |
|------|------|-------------|
| `SN` | inductive | Strongly normalizing: every reduction chain terminates |
| `Neutral` | inductive | Neutral terms: variables and applications of neutrals to SN terms |

## Theorems

| # | Name | Signature | Visibility |
|---|------|-----------|------------|
| 1 | `sn_step` | `t ⭢βᶠ t' → SN t → SN t'` | PUBLIC |
| 2 | `sn_fvar` | `SN (fvar x)` | PUBLIC |
| 3 | `sn_neutral` | `Neutral t → SN t` | PUBLIC |
| 4 | `sn_abs_app_multiApp` | `SN N → SN (multiApp (M ^ N) Ps) → ... → SN (multiApp (M.abs.app N) Ps)` | PUBLIC |

## Statistics

- **Theorems/Lemmas**: 4 major + auxiliary
- **Lines of code**: 160
- **Authors**: David Wegmann
