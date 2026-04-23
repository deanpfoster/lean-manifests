# Cslib.Foundations.Semantics.LTS.Divergence

## Module Summary

Defines divergence for LTSs with internal transitions (tau). A state is divergent if it admits an infinite execution with all-tau labels. `DivergenceFree` is the class of LTSs with no divergent states.

## Vocabulary

| Name | Kind | Description |
|------|------|-------------|
| `DivergentTrace` | def | All labels in an omega-sequence are tau |
| `Divergent` | def | State has a divergent execution |
| `DivergenceFree` | class | No state is divergent |

## Theorems

### PUBLIC

| # | Name | Signature |
|---|------|-----------|
| 1 | `divergentTrace_drop` | `theorem divergentTrace_drop [HasTau Label] {mus : omegaSequence Label} (h : DivergentTrace mus) (n : Nat) : DivergentTrace (mus.drop n)` |

### INTERNAL

None.

## Counts

- **PUBLIC**: 1
- **INTERNAL**: 0
