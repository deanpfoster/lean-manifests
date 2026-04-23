# PerfectSecrecy.Internal.PerfectSecrecy

Internal proofs for perfect secrecy: equivalence with message-ciphertext independence, both directions of the ciphertext indistinguishability characterization, and Shannon's key-space bound.

## Theorems

| # | Name | Signature | Visibility |
|---|------|-----------|------------|
| 1 | `perfectlySecret_iff_indep` | `PerfectlySecret ↔ ∀ msgDist m c, jointDist (m,c) = msgDist m * marginal c` | INTERNAL |
| 2 | `perfectlySecret_of_ciphertextIndist` | `CiphertextIndist → PerfectlySecret` | INTERNAL |
| 3 | `ciphertextIndist_of_perfectlySecret` | `PerfectlySecret → CiphertextIndist` | INTERNAL |
| 4 | `shannonKeySpace` | `[Finite K] → PerfectlySecret → Nat.card K ≥ Nat.card M` | INTERNAL |

## Statistics

- **Theorems/Lemmas**: 4
- **Lines of code**: 132
- **Authors**: Samuel Schlesinger
