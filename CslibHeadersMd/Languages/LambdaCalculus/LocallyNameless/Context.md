# LambdaCalculus.LocallyNameless.Context

Typing contexts as lists of free-variable/type pairs for the locally nameless lambda calculus.

## Vocabulary

| Name | Kind | Description |
|------|------|-------------|
| `Context` | abbrev | `List ((_ : α) × β)` — a typing context |
| `Context.dom` | def | Domain as a `Finset` of free variables |
| `Context.map_val` | def | Map a function over the types in a context |

## Theorems

| # | Name | Signature | Visibility |
|---|------|-----------|------------|
| 1 | `map_val_keys` | `Γ.keys = (Γ.map_val f).keys` | PUBLIC |
| 2 | `map_val_mem` | `σ ∈ Γ.dlookup x → f σ ∈ (Γ.map_val f).dlookup x` | PUBLIC |

## Statistics

- **Theorems/Lemmas**: 2
- **Lines of code**: 86
- **Authors**: Chris Henson
