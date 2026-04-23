# PerfectSecrecy.Basic

Main characterization theorems for perfect secrecy: equivalence with ciphertext indistinguishability and Shannon's key-space bound.

## Theorems

| # | Name | Signature | Visibility |
|---|------|-----------|------------|
| 1 | `perfectlySecret_iff_ciphertextIndist` | `scheme.PerfectlySecret ↔ scheme.CiphertextIndist` | PUBLIC |
| 2 | `perfectlySecret_keySpace_ge` | `[Finite K] → scheme.PerfectlySecret → Nat.card K ≥ Nat.card M` | PUBLIC |

## Statistics

- **Theorems/Lemmas**: 2
- **Lines of code**: 52
- **Authors**: Samuel Schlesinger
