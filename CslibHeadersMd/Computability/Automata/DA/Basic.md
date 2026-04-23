# Cslib.Computability.Automata.DA.Basic

## Summary
Defines deterministic automata (DA) as FLTS with an initial state, plus extensions for finite-word acceptance (FinAcc/DFA), Buchi acceptance, and Muller acceptance. Provides the infinite run construction and key run equations.

## Vocabulary
| Name | Kind | Description |
|------|------|-------------|
| `DA` | structure | Deterministic automaton: FLTS + initial state |
| `DA.FinAcc` | structure | DA with a set of accepting states (generalised DFA) |
| `DA.Buchi` | structure | Deterministic Buchi automaton |
| `DA.Muller` | structure | Deterministic Muller automaton |
| `DA.run` | def | Infinite run of a DA on an omega-sequence |
| `DA.run'` | def | Helper for defining `run` |

## Theorems

| # | Name | Signature | Visibility |
|---|------|-----------|------------|
| 1 | `DA.run_zero` | `{da : DA State Symbol} {xs : ωSequence Symbol} : da.run xs 0 = da.start` | PUBLIC |
| 2 | `DA.run_succ` | `{da : DA State Symbol} {xs : ωSequence Symbol} {n : ℕ} : da.run xs (n + 1) = da.tr (da.run xs n) (xs n)` | PUBLIC |
| 3 | `DA.mtr_extract_eq_run` | `{da : DA State Symbol} {xs : ωSequence Symbol} {n : ℕ} : da.mtr da.start (xs.extract 0 n) = da.run xs n` | PUBLIC |

## Instances

| # | Name | Signature | Visibility |
|---|------|-----------|------------|
| 1 | `DA.FinAcc.Acceptor` | `instance : Acceptor (DA.FinAcc State Symbol) Symbol` | PUBLIC |
| 2 | `DA.Buchi.ωAcceptor` | `instance : ωAcceptor (Buchi State Symbol) Symbol` | PUBLIC |
| 3 | `DA.Muller.ωAcceptor` | `instance : ωAcceptor (Muller State Symbol) Symbol` | PUBLIC |

## Statistics
- Theorems/Lemmas: 3
- Definitions/Structures: 6
- Instances: 3
- Lines of code: 124
- Imports: Cslib.Computability.Automata.Acceptors.{Acceptor,OmegaAcceptor}, Cslib.Foundations.Data.OmegaSequence.InfOcc, Cslib.Foundations.Semantics.FLTS.Basic
