# Cslib.Foundations.Data.Set.Saturation

## Module Summary

Defines `Set.Saturates`: a family of sets `f` saturates `s` if any `f i` intersecting `s` is entirely contained in `s`. Proves saturation is closed under complement and characterizes saturated sets as unions.

## Vocabulary

| Name | Kind | Description |
|------|------|-------------|
| `Set.Saturates` | def | `f : iota -> Set alpha` saturates `s` iff intersection implies subset |

## Theorems

### PUBLIC

| # | Name | Signature |
|---|------|-----------|
| 1 | `saturates_compl` | `theorem saturates_compl (hs : Saturates f s) : Saturates f s^c` |
| 2 | `saturates_eq_biUnion` | `theorem saturates_eq_biUnion (hs : Saturates f s) (hc : Union_i f i = univ) : s = Union_i_in {i | (f i inter s).Nonempty} f i` |

### INTERNAL

None.

## Counts

- **PUBLIC**: 2
- **INTERNAL**: 0
