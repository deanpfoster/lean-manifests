# LambdaCalculus.LocallyNameless.Fsub.Subtype

Defines the subtyping relation for System F-sub and proves reflexivity, transitivity, weakening, and narrowing.

## Vocabulary

| Name | Kind | Description |
|------|------|-------------|
| `Sub` | inductive | Subtyping: top, refl_tvar, trans_tvar, arrow, all, sum |

## Theorems

| # | Name | Signature | Visibility |
|---|------|-----------|------------|
| 1 | `Sub.refl` | `Γ.Wf → σ.Wf Γ → Sub Γ σ σ` | PUBLIC |
| 2 | `Sub.trans` | `Sub Γ σ δ → Sub Γ δ τ → Sub Γ σ τ` | PUBLIC |
| 3 | `Sub.weaken` | `Sub (Γ ++ Θ) σ σ' → (Γ ++ Δ ++ Θ).Wf → Sub (Γ ++ Δ ++ Θ) σ σ'` | PUBLIC |
| 4 | `Sub.narrow` | `Sub Δ δ δ' → Sub (Γ ++ ⟨X, .sub δ'⟩ :: Δ) σ τ → Sub (Γ ++ ⟨X, .sub δ⟩ :: Δ) σ τ` | PUBLIC |
| 5 | `Sub.map_subst` | type substitution in subtyping | PUBLIC |
| 6 | `Sub.strengthen` | subtyping under strengthening | PUBLIC |

## Statistics

- **Theorems/Lemmas**: 6 major
- **Lines of code**: 173
- **Authors**: Chris Henson
