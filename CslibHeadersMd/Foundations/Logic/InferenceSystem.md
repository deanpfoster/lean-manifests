# Cslib.Foundations.Logic.InferenceSystem

## Module Summary

Defines the `InferenceSystem` typeclass providing notation `down-arrow a` for derivations, together with `Derivable` (nonemptiness of derivation type) and conversion between derivations and derivability.

## Vocabulary

| Name | Kind | Description |
|------|------|-------------|
| `InferenceSystem` | class | Typeclass with `derivation (s : alpha) : Sort v` |
| `InferenceSystem.Derivable` | def | `Nonempty (down-arrow a)` |

## Theorems

### PUBLIC

| # | Name | Signature |
|---|------|-----------|
| 1 | `rwConclusion` | `def rwConclusion [InferenceSystem alpha] {Gamma Delta : alpha} (h : Gamma = Delta) (p : down-arrow Gamma) : down-arrow Delta` |
| 2 | `Derivable.fromDerivation` | `theorem Derivable.fromDerivation [InferenceSystem alpha] {a : alpha} (d : down-arrow a) : Derivable a` |
| 3 | `Derivable.toDerivation` | `noncomputable def Derivable.toDerivation [InferenceSystem alpha] {a : alpha} (d : Derivable a) : down-arrow a` |

### INTERNAL

None.

## Counts

- **PUBLIC**: 3
- **INTERNAL**: 0
