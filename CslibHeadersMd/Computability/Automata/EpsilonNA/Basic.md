# Cslib.Computability.Automata.EpsilonNA.Basic

## Summary
Defines nondeterministic automata with epsilon-transitions (epsilon-NA) as an NA over `Option Symbol`, where `none` represents epsilon. Epsilon-closure is expressed via tau-closure of the underlying LTS. Defines finite-word acceptance via saturated multistep transitions.

## Vocabulary
| Name | Kind | Description |
|------|------|-------------|
| `εNA` | structure | Nondeterministic automaton with epsilon-transitions |
| `εNA.εClosure` | abbrev | Epsilon-closure of a set of states (via tau-closure) |
| `εNA.FinAcc` | structure | Epsilon-NA with accepting states |

## Instances

| # | Name | Signature | Visibility |
|---|------|-----------|------------|
| 1 | `εNA.FinAcc.Acceptor` | `instance : Acceptor (FinAcc State Symbol) Symbol` | PUBLIC |

## Statistics
- Theorems/Lemmas: 0
- Definitions/Structures: 3
- Instances: 1
- Lines of code: 58
- Imports: Cslib.Computability.Automata.NA.Basic, Cslib.Foundations.Semantics.LTS.HasTau
