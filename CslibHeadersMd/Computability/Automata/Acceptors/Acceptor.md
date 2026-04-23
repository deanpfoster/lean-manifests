# Cslib.Computability.Automata.Acceptors.Acceptor

## Summary
Defines the `Acceptor` class for machines that recognise finite strings (lists of symbols), along with the notion of the language accepted by an acceptor.

## Vocabulary
| Name | Kind | Description |
|------|------|-------------|
| `Acceptor` | class | A machine that recognises strings (lists of symbols in an alphabet) |
| `Acceptor.language` | def | The language (set of strings) accepted by an acceptor |

## Theorems

| # | Name | Signature | Visibility |
|---|------|-----------|------------|
| 1 | `Acceptor.mem_language` | `[Acceptor A Symbol] (a : A) (xs : List Symbol) : xs ∈ language a ↔ Accepts a xs` | PUBLIC |

## Statistics
- Theorems/Lemmas: 1
- Definitions/Structures: 2 (Acceptor class, language def)
- Lines of code: 38
- Imports: Cslib.Init, Mathlib.Computability.Language
