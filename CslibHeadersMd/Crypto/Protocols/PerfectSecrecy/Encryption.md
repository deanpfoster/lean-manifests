# PerfectSecrecy.Encryption

Defines private-key encryption schemes (Gen, Enc, Dec) with a correctness condition, following Katz-Lindell Definition 2.1.

## Vocabulary

| Name | Kind | Description |
|------|------|-------------|
| `EncScheme` | structure | Private-key encryption scheme: gen (PMF Key), enc, dec, correct |
| `EncScheme.ofPure` | def | Build a scheme from deterministic enc/dec with left-inverse property |

## Statistics

- **Theorems/Lemmas**: 0
- **Definitions**: 2
- **Lines of code**: 62
- **Authors**: Samuel Schlesinger
