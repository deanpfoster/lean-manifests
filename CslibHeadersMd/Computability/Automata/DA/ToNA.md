# Cslib.Computability.Automata.DA.ToNA

## Summary
Implements the standard translation of deterministic automata into nondeterministic automata, proving that DA.FinAcc and DA.Buchi embed into NA.FinAcc and NA.Buchi with preserved languages.

## Vocabulary
| Name | Kind | Description |
|------|------|-------------|
| `DA.toNA` | def | Embed a DA as a special case of NA |
| `DA.FinAcc.toNAFinAcc` | def | Embed a DA.FinAcc as NA.FinAcc |
| `DA.Buchi.toNABuchi` | def | Embed a DA.Buchi as NA.Buchi |

## Theorems

| # | Name | Signature | Visibility |
|---|------|-----------|------------|
| 1 | `toNA_run` | `{a : DA State Symbol} {xs : ωSequence Symbol} {ss : ωSequence State} : a.toNA.Run xs ss ↔ a.run xs = ss` | PUBLIC |
| 2 | `FinAcc.toNAFinAcc_language_eq` | `{a : DA.FinAcc State Symbol} : language a.toNAFinAcc = language a` | PUBLIC |
| 3 | `Buchi.toNABuchi_language_eq` | `{a : DA.Buchi State Symbol} : language a.toNABuchi = language a` | PUBLIC |

## Instances

| # | Name | Signature | Visibility |
|---|------|-----------|------------|
| 1 | `Coe (DA State Symbol) (NA State Symbol)` | coercion via `toNA` | PUBLIC |

## Statistics
- Theorems/Lemmas: 3
- Definitions: 3
- Instances: 1
- Lines of code: 94
- Imports: Cslib.Computability.Automata.DA.Basic, Cslib.Computability.Automata.NA.Basic, Cslib.Foundations.Semantics.FLTS.FLTSToLTS
