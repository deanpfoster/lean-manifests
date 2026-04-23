# Cslib.Computability.Languages.ExampleEventuallyZero

## Summary
Provides the concrete example of `eventually_zero`, an omega-regular language (accepted by a 2-state NBA) that is NOT accepted by any deterministic Buchi automaton. Adapted from Thomas (1990), Example 4.2.

## Vocabulary
| Name | Kind | Description |
|------|------|-------------|
| `eventually_zero` | def | The omega-language of sequences over Fin 2 that are eventually 0 |
| `eventually_zero_na` | def | A 2-state NBA accepting `eventually_zero` |

## Theorems

| # | Name | Signature | Visibility |
|---|------|-----------|------------|
| 1 | `eventually_zero_accepted_by_na_buchi` | `language eventually_zero_na = eventually_zero` | PUBLIC |
| 2 | `eventually_zero_not_omegaLim` | `¬ ∃ l : Language (Fin 2), l↗ω = eventually_zero` | PUBLIC |

## Statistics
- Theorems/Lemmas: 2 (plus 4 private helper lemmas)
- Definitions: 2
- Lines of code: 122
- Imports: Cslib.Computability.Automata.NA.Basic
