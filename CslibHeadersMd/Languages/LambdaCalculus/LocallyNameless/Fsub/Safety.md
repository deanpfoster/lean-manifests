# LambdaCalculus.LocallyNameless.Fsub.Safety

Type safety for System F-sub: preservation and progress.

## Theorems

| # | Name | Signature | Visibility |
|---|------|-----------|------------|
| 1 | `Typing.preservation` | `Typing Γ t τ → t ⭢βᵛ t' → Typing Γ t' τ` | PUBLIC |
| 2 | `Typing.progress` | `Typing [] t τ → t.Value ∨ ∃ t', t ⭢βᵛ t'` | PUBLIC |

## Statistics

- **Theorems/Lemmas**: 2 major
- **Lines of code**: 158
- **Authors**: Chris Henson
