# Cslib.Foundations.Data.OmegaSequence.InfOcc

## Module Summary

Defines the set of infinitely-occurring elements in an omega-sequence (`infOcc`). Provides characterizations of "frequently" via strictly monotonic subsequences, infinite pigeonhole for finite types, and interaction of "frequently" with strictly monotonic segmentation.

## Vocabulary

| Name | Kind | Description |
|------|------|-------------|
| `omegaSequence.infOcc` | def | The set of elements appearing infinitely often: `{ x | exists^f k in atTop, xs k = x }` |

## Theorems

### PUBLIC

| # | Name | Signature |
|---|------|-----------|
| 1 | `frequently_iff_strictMono` | `theorem frequently_iff_strictMono {p : Nat -> Prop} : (exists^f n in atTop, p n) <-> exists f : Nat -> Nat, StrictMono f and forall m, p (f m)` |
| 2 | `frequently_in_finite_type` | `theorem frequently_in_finite_type [Finite alpha] {s : Set alpha} {xs : omegaSequence alpha} : (exists^f k in atTop, xs k in s) <-> exists x in s, exists^f k in atTop, xs k = x` |
| 3 | `frequently_in_strictMono` | `theorem frequently_in_strictMono {p : Nat -> Prop} {f : Nat -> Nat} (hm : StrictMono f) (hf : exists^f k in atTop, p k) : exists^f n in atTop, exists k, k < f (n + 1) - f n and p (f n + k)` |
| 4 | `strictMono_of_infinite` | `theorem strictMono_of_infinite {ns : Set Nat} (h : ns.Infinite) : exists phi : Nat -> Nat, StrictMono phi and range phi = ns` |

### INTERNAL

None.

## Counts

- **PUBLIC**: 4
- **INTERNAL**: 0
