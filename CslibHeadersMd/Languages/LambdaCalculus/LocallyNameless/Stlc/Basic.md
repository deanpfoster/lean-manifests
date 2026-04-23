# LambdaCalculus.LocallyNameless.Stlc.Basic

Simply typed lambda calculus with locally nameless syntax: types, typing derivations, weakening, and substitution.

## Vocabulary

| Name | Kind | Description |
|------|------|-------------|
| `Stlc.Ty` | inductive | Types: base types and arrow types |
| `Stlc.Typing` | inductive | Typing derivation: var, abs (cofinite), app |

## Theorems

| # | Name | Signature | Visibility |
|---|------|-----------|------------|
| 1 | `Typing.perm` | `Γ ⊢ t ∶ τ → Γ.Perm Δ → Δ ⊢ t ∶ τ` | PUBLIC |
| 2 | `Typing.weaken` | `Γ ⊢ t ∶ τ → (Γ ++ Δ)✓ → Γ ++ Δ ⊢ t ∶ τ` | PUBLIC |
| 3 | `Typing.lc` | `Γ ⊢ t ∶ τ → t.LC` | PUBLIC |
| 4 | `Typing.typing_subst_head` | `⟨x,σ⟩ :: Γ ⊢ t ∶ τ → Γ ⊢ s ∶ σ → Γ ⊢ t[x := s] ∶ τ` | PUBLIC |
| 5 | `Typing.preservation_open` | `(∀ x ∉ xs, ⟨x,σ⟩ :: Γ ⊢ m ^ fvar x ∶ τ) → Γ ⊢ n ∶ σ → Γ ⊢ m ^ n ∶ τ` | PUBLIC |

## Statistics

- **Theorems/Lemmas**: 5
- **Lines of code**: 133
- **Authors**: Chris Henson
