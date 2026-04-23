# Cslib.Computability.Automata.DA.Buchi

## Summary
Proves that the omega-language accepted by a deterministic Buchi automaton equals the omega-limit of the language accepted by the same automaton viewed as a FinAcc (DFA).

## Vocabulary
| Name | Kind | Description |
|------|------|-------------|
| `buchi_eq_finAcc_omegaLim` | theorem | Links Buchi acceptance to omega-limit of finite acceptance |

## Theorems

| # | Name | Signature | Visibility |
|---|------|-----------|------------|
| 1 | `buchi_eq_finAcc_omegaLim` | `{da : DA State Symbol} {acc : Set State} : language (Buchi.mk da acc) = (language (FinAcc.mk da acc))↗ω` | PUBLIC |

## Statistics
- Theorems/Lemmas: 1
- Lines of code: 34
- Imports: Cslib.Computability.Automata.DA.Basic
