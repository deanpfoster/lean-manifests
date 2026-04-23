# LambdaCalculus.LocallyNameless.Untyped.MultiApp

Defines multi-application `multiApp f [x1,...,xn]` and proves congruence lemmas for beta-reduction on multi-applications. Provides inversion lemmas for reducing `(abs M).app N` applied to a list.

## Vocabulary

| Name | Kind | Description |
|------|------|-------------|
| `multiApp` | def | Left-associative application to a list |
| `ListFullBeta` | inductive | Single-step reduction in a list of arguments |

## Statistics

- **Theorems/Lemmas**: ~10 congruence and inversion lemmas
- **Lines of code**: 142
- **Authors**: David Wegmann
