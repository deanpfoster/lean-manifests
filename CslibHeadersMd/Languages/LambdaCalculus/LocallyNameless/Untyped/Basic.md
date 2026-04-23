# LambdaCalculus.LocallyNameless.Untyped.Basic

Defines the locally nameless representation of untyped lambda terms: syntax, opening, closing, substitution, free variables, and local closure.

## Vocabulary

| Name | Kind | Description |
|------|------|-------------|
| `Term` | inductive | Locally nameless terms: bvar, fvar, abs, app |
| `Term.openRec` | def | Open the i-th bound variable with a term |
| `Term.open'` | def | Open the closest binding |
| `Term.closeRec` | def | Close: replace fvar x with bvar k |
| `Term.subst` | def | Substitution of free variables |
| `Term.fv` | def | Free variables as a Finset |
| `Term.LC` | inductive | Locally closed terms |
| `Term.Value` | inductive | Values (lambda abstractions) |

## Statistics

- **Theorems/Lemmas**: 0 (definitions only)
- **Lines of code**: 157
- **Authors**: Chris Henson
