# Cslib.Computability.Automata.DA.Prod

## Summary
Defines the product of two deterministic automata and proves the product multistep transition decomposes component-wise.

## Vocabulary
| Name | Kind | Description |
|------|------|-------------|
| `DA.prod` | def | Product of two DAs, with paired states and start |

## Theorems

| # | Name | Signature | Visibility |
|---|------|-----------|------------|
| 1 | `prod_mtr_eq` | `(da1 : DA State1 Symbol) (da2 : DA State2 Symbol) (s : State1 × State2) (xs : List Symbol) : (da1.prod da2).mtr s xs = (da1.mtr s.fst xs, da2.mtr s.snd xs)` | PUBLIC |

## Statistics
- Theorems/Lemmas: 1
- Definitions: 1
- Lines of code: 42
- Imports: Cslib.Computability.Automata.DA.Basic, Cslib.Foundations.Semantics.FLTS.Prod
