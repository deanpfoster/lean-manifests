# Cslib.Computability.Automata.NA.Prod

## Summary
Defines the product of an indexed family of nondeterministic automata using dependent function types, and proves runs of the product project to component runs and vice versa.

## Vocabulary
| Name | Kind | Description |
|------|------|-------------|
| `NA.iProd` | def | Product of indexed family of NAs with Pi-type states |

## Theorems

| # | Name | Signature | Visibility |
|---|------|-----------|------------|
| 1 | `iProd_run_iff` | `{na : (i : I) → NA (State i) Symbol} {xs : ωSequence Symbol} {ss : ωSequence (Π i, State i)} : (iProd na).Run xs ss ↔ ∀ i, (na i).Run xs (ss.map (· i))` | PUBLIC |

## Statistics
- Theorems/Lemmas: 1
- Definitions: 1
- Lines of code: 47
- Imports: Cslib.Computability.Automata.NA.Basic
