# Cslib.Computability.Automata.NA.BuchiEquiv

## Summary
Defines reindexing (state renaming) for nondeterministic Buchi automata via equivalences on states, and proves that reindexing preserves runs and languages.

## Vocabulary
| Name | Kind | Description |
|------|------|-------------|
| `Buchi.reindex` | def | Lifts a state equivalence to an equivalence on NBAs |

## Theorems

| # | Name | Signature | Visibility |
|---|------|-----------|------------|
| 1 | `reindex_run_iff` | `{f : State ≃ State'} {nba : Buchi State Symbol} {xs : ωSequence Symbol} {ss' : ωSequence State'} : (nba.reindex f).Run xs ss' ↔ nba.Run xs (ss'.map f.symm)` | PUBLIC |
| 2 | `reindex_run_iff'` | `{f : State ≃ State'} {nba : Buchi State Symbol} {xs : ωSequence Symbol} {ss : ωSequence State} : (nba.reindex f).Run xs (ss.map f) ↔ nba.Run xs ss` | PUBLIC |
| 3 | `reindex_language_eq` | `{f : State ≃ State'} {nba : Buchi State Symbol} : language (nba.reindex f) = language nba` | PUBLIC |

## Statistics
- Theorems/Lemmas: 3
- Definitions: 1
- Lines of code: 71
- Imports: Cslib.Computability.Automata.NA.Basic
