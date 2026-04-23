# Cslib.Computability.Automata.NA.Hist

## Summary
Defines the construction of adding a history state to a nondeterministic automaton, where the history evolves depending on the original state and past history but does not constrain the original transitions. Proves projection and lifting theorems.

## Vocabulary
| Name | Kind | Description |
|------|------|-------------|
| `NA.addHist` | def | Augments an NA with a history state component |
| `makeHist` | def | Builds a history sequence from a run of the original automaton |

## Theorems

| # | Name | Signature | Visibility |
|---|------|-----------|------------|
| 1 | `hist_run_proj` | `{xs : ωSequence Symbol} {ss : ωSequence (State × Hist)} (h_run : (na.addHist start' tr').Run xs ss) : na.Run xs (ss.map fst)` | PUBLIC |
| 2 | `hist_run_exists` | `{xs : ωSequence Symbol} {ss : ωSequence State} (h_run : na.Run xs ss) : ∃ ss', (na.addHist start' tr').Run xs ss' ∧ ss'.map fst = ss` | PUBLIC |

## Statistics
- Theorems/Lemmas: 2
- Definitions: 2
- Lines of code: 63
- Imports: Cslib.Computability.Automata.NA.Basic
