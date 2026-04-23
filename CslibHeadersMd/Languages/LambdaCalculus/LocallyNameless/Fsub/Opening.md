# LambdaCalculus.LocallyNameless.Fsub.Opening

Defines opening, local closure, and substitution for System F-sub types and terms. Proves that substitution distributes over opening and that LC types/terms are unchanged by opening.

## Theorems (selected)

| # | Name | Signature | Visibility |
|---|------|-----------|------------|
| 1 | `Ty.openRec_lc` | `σ.LC → σ = σ⟦X ↝ τ⟧ᵞ` | PUBLIC |
| 2 | `Ty.open_subst` | `(σ ^ᵞ τ)[X := δ] = σ[X := δ] ^ᵞ τ[X := δ]` | PUBLIC |
| 3 | `Ty.subst_lc` | `σ.LC → τ.LC → σ[X := τ].LC` | PUBLIC |
| 4 | `Term.subst_ty_lc` | `t.LC → δ.LC → t[X := δ].LC` | PUBLIC |
| 5 | `Term.subst_tm_lc` | `t.LC → s.LC → t[x := s].LC` | PUBLIC |

## Statistics

- **Theorems/Lemmas**: ~30
- **Lines of code**: 432
- **Authors**: Chris Henson
