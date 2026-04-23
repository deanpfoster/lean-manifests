# Cslib.Computability.Automata.NA.ToDA

## Summary
Implements the standard subset construction converting a nondeterministic automaton into a deterministic one, and proves the resulting DA.FinAcc has the same language.

## Vocabulary
| Name | Kind | Description |
|------|------|-------------|
| `NA.toDA` | def | Converts NA to DA via subset construction |
| `NA.FinAcc.toDAFinAcc` | def | Converts NA.FinAcc to DA.FinAcc via subset construction |

## Theorems

| # | Name | Signature | Visibility |
|---|------|-----------|------------|
| 1 | `toDAFinAcc_language_eq` | `{na : NA.FinAcc State Symbol} : language na.toDAFinAcc = language na` | PUBLIC |

## Statistics
- Theorems/Lemmas: 1
- Definitions: 2
- Lines of code: 54
- Imports: Cslib.Computability.Automata.DA.Basic, Cslib.Computability.Automata.NA.Basic, Cslib.Foundations.Semantics.FLTS.LTSToFLTS
