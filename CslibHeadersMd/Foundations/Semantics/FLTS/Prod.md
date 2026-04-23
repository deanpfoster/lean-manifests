# Cslib.Foundations.Semantics.FLTS.Prod

## Module Summary

Defines the product of two FLTSs with the same label type. Proves the product multi-step transition decomposes into component-wise multi-step transitions.

## Vocabulary

| Name | Kind | Description |
|------|------|-------------|
| `FLTS.prod` | def | Product of two FLTSs: `FLTS (State1 x State2) Label` |

## Theorems

### PUBLIC

| # | Name | Signature |
|---|------|-----------|
| 1 | `prod_mtr_eq` | `theorem prod_mtr_eq (flts1 : FLTS State1 Label) (flts2 : FLTS State2 Label) (s : State1 x State2) (mus : List Label) : (flts1.prod flts2).mtr s mus = (flts1.mtr s.fst mus, flts2.mtr s.snd mus)` |

### INTERNAL

None.

## Counts

- **PUBLIC**: 1
- **INTERNAL**: 0
