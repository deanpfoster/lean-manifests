# LambdaCalculus.LocallyNameless.Fsub.WellFormed

Defines well-formedness of types and environments in System F-sub. Proves weakening, narrowing, and strengthening for well-formedness.

## Vocabulary

| Name | Kind | Description |
|------|------|-------------|
| `Ty.Wf` | inductive | A type is well-formed relative to an environment |
| `Env.Wf` | inductive | An environment is well-formed (no duplicate keys, all types well-formed) |

## Theorems (selected)

| # | Name | Signature | Visibility |
|---|------|-----------|------------|
| 1 | `Ty.Wf.lc` | `σ.Wf Γ → σ.LC` | PUBLIC |
| 2 | `Ty.Wf.weaken` | `σ.Wf (Γ ++ Θ) → (Γ ++ Δ ++ Θ)✓ → σ.Wf (Γ ++ Δ ++ Θ)` | PUBLIC |
| 3 | `Ty.Wf.narrow` | well-formedness is preserved under context narrowing | PUBLIC |
| 4 | `Env.Wf.narrow` | environment well-formedness under narrowing | PUBLIC |

## Statistics

- **Theorems/Lemmas**: ~15
- **Lines of code**: 196
- **Authors**: Chris Henson
