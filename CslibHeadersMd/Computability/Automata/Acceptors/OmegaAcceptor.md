# Cslib.Computability.Automata.Acceptors.OmegaAcceptor

## Summary
Defines the `ωAcceptor` class for machines that recognise infinite sequences of symbols, along with the notion of the omega-language accepted by an omega-acceptor.

## Vocabulary
| Name | Kind | Description |
|------|------|-------------|
| `ωAcceptor` | class | A machine that recognises infinite sequences of symbols |
| `ωAcceptor.language` | def | The omega-language (set of infinite sequences) accepted by an omega-acceptor |

## Theorems

| # | Name | Signature | Visibility |
|---|------|-----------|------------|
| 1 | `ωAcceptor.mem_language` | `[ωAcceptor A Symbol] (a : A) (xs : ωSequence Symbol) : xs ∈ language a ↔ Accepts a xs` | PUBLIC |

## Statistics
- Theorems/Lemmas: 1
- Definitions/Structures: 2 (ωAcceptor class, language def)
- Lines of code: 36
- Imports: Cslib.Computability.Languages.OmegaLanguage
