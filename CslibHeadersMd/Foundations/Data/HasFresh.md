# Cslib.Foundations.Data.HasFresh

## Module Summary

Defines the `HasFresh` typeclass for types with a computable function producing fresh elements not in a given `Finset`. Provides instances for `Nat`, `Int`, `Rat`, `Finset`, `Multiset`, and `Nat -> Nat`. Includes a `free_union` term elaborator that automatically unions all in-scope variables/finsets of a given type.

## Vocabulary

| Name | Kind | Description |
|------|------|-------------|
| `HasFresh` | class | Types with a computable `fresh : Finset α → α` and proof `fresh_notMem` |
| `FreeUnionConfig` | structure | Configuration for `free_union` elaborator |
| `HasFresh.ofNatEmbed` | def | Construct `HasFresh` from an embedding `ℕ ↪ α` |
| `HasFresh.ofSucc` | def | Construct `HasFresh` from a strict successor function |

## Theorems

### PUBLIC

| # | Name | Signature |
|---|------|-----------|
| 1 | `HasFresh.fresh_exists` | `theorem HasFresh.fresh_exists {α : Type u} [HasFresh α] (s : Finset α) : ∃ a, a ∉ s` |
| 2 | `HasFresh.to_infinite` | `instance HasFresh.to_infinite (α : Type u) [HasFresh α] : Infinite α` |
| 3 | `HasFresh.of_infinite` | `noncomputable instance HasFresh.of_infinite (α : Type u) [Infinite α] : HasFresh α` |

### INTERNAL

None.

## Counts

- **PUBLIC**: 3
- **INTERNAL**: 0
