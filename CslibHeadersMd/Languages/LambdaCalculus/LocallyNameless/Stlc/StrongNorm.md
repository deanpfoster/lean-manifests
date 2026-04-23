# LambdaCalculus.LocallyNameless.Stlc.StrongNorm

Strong normalization of the simply typed lambda calculus via saturated sets and a semantic interpretation.

## Vocabulary

| Name | Kind | Description |
|------|------|-------------|
| `Saturated` | structure | A set of terms closed under neutrals and top-level beta |
| `semanticMap` | def | Maps each type to a saturated set |
| `entails` | abbrev | Semantic validity: `Γ ⊢ t ∶ τ` implies `t` is in the semantic map of `τ` |

## Theorems

| # | Name | Signature | Visibility |
|---|------|-----------|------------|
| 1 | `semanticMap_saturated` | `Saturated (semanticMap τ)` | PUBLIC |
| 2 | `soundness` | `Γ ⊢ t ∶ τ → entails Γ t τ` | PUBLIC |
| 3 | `strong_norm` | `Γ ⊢ t ∶ τ → SN t` | PUBLIC |

## Statistics

- **Theorems/Lemmas**: 3 major
- **Lines of code**: 125
- **Authors**: David Wegmann
