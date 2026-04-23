# LambdaCalculus.LocallyNameless.Fsub.Reduction

Defines call-by-value reduction for System F-sub: values, the reduction relation, and proves terms in a reduction are locally closed.

## Vocabulary

| Name | Kind | Description |
|------|------|-------------|
| `Term.Value` | inductive | Values: abs, tabs, inl, inr |
| `Term.Red` | inductive | Call-by-value reduction (12 rules) |

## Theorems

| # | Name | Signature | Visibility |
|---|------|-----------|------------|
| 1 | `Red.lc` | `t ⭢βᵛ t' → t.LC ∧ t'.LC` | PUBLIC |

## Statistics

- **Theorems/Lemmas**: 1
- **Lines of code**: 121
- **Authors**: Chris Henson
