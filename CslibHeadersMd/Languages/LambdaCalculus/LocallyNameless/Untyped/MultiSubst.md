# LambdaCalculus.LocallyNameless.Untyped.MultiSubst

Defines simultaneous multi-substitution `multiSubst E M` from an environment and proves it commutes with opening and propagates through app/abs.

## Vocabulary

| Name | Kind | Description |
|------|------|-------------|
| `Env` | abbrev | Environment: list of (variable, term) pairs |
| `multiSubst` | def | Multi-substitution from environment |
| `env_LC` | abbrev | All terms in an environment are locally closed |

## Statistics

- **Theorems/Lemmas**: 5 (propagation through app, abs, opening, fvar)
- **Lines of code**: 89
- **Authors**: David Wegmann
