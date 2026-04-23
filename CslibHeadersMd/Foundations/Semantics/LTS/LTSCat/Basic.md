# Cslib.Foundations.Semantics.LTS.LTSCat.Basic

## Module Summary

Defines the category of labelled transition systems (`LTSCat`) following Winskel-Nielsen. An `LTSCat` bundles state type, label type, and LTS. Morphisms consist of a state map, a partial label map, and preservation of transitions. Proves LTSs form a `CategoryTheory.Category`.

## Vocabulary

| Name | Kind | Description |
|------|------|-------------|
| `LTS.withIdle` | def | Extend transitions with idle (identity) transitions via `Option Label` |
| `LTSCat` | structure | Bundled LTS: `State`, `Label`, `lts` |
| `LTS.Morphism` | structure | State map, partial label map, transition preservation |
| `LTS.Morphism.id` | def | Identity morphism |
| `LTS.Morphism.comp` | def | Composition of morphisms (Kleisli composition on labels) |

## Theorems

### PUBLIC

| # | Name | Signature |
|---|------|-----------|
| 1 | (CategoryTheory.Category instance) | `instance : CategoryTheory.Category LTSCat` |

### INTERNAL

None.

## Counts

- **PUBLIC**: 1
- **INTERNAL**: 0
