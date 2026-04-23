# Cslib.Computability.Automata.NA.Basic

## Summary
Defines nondeterministic automata (NA) as LTS with a set of initial states, plus extensions for finite-word acceptance (FinAcc/NFA), Buchi acceptance, and Muller acceptance. Provides the infinite run structure.

## Vocabulary
| Name | Kind | Description |
|------|------|-------------|
| `NA` | structure | Nondeterministic automaton: LTS + set of initial states |
| `NA.Run` | structure | Infinite run of an NA: start state membership + omega execution |
| `NA.FinAcc` | structure | NA with a set of accepting states (generalised NFA) |
| `NA.Buchi` | structure | Nondeterministic Buchi automaton |
| `NA.Muller` | structure | Nondeterministic Muller automaton |

## Instances

| # | Name | Signature | Visibility |
|---|------|-----------|------------|
| 1 | `NA.FinAcc.Acceptor` | `instance : Acceptor (FinAcc State Symbol) Symbol` | PUBLIC |
| 2 | `NA.Buchi.ωAcceptor` | `instance : ωAcceptor (Buchi State Symbol) Symbol` | PUBLIC |
| 3 | `NA.Muller.ωAcceptor` | `instance : ωAcceptor (Muller State Symbol) Symbol` | PUBLIC |

## Statistics
- Theorems/Lemmas: 0
- Definitions/Structures: 5
- Instances: 3
- Lines of code: 104
- Imports: Cslib.Computability.Automata.Acceptors.{Acceptor,OmegaAcceptor}, Cslib.Foundations.Data.OmegaSequence.InfOcc, Cslib.Foundations.Semantics.LTS.OmegaExecution
