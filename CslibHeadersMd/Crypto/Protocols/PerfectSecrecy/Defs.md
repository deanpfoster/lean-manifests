# PerfectSecrecy.Defs

Core definitions for perfect secrecy: ciphertext distribution, joint distribution, posterior message distribution, and the formal definitions of perfect secrecy and ciphertext indistinguishability.

## Vocabulary

| Name | Kind | Description |
|------|------|-------------|
| `ciphertextDist` | def | Distribution of `Enc_K(m)` when `K ← Gen` |
| `jointDist` | def | Joint distribution `(M, C)` given a message prior |
| `marginalCiphertextDist` | def | Marginal ciphertext distribution |
| `posteriorMsgDist` | def | Posterior `Pr[M | C=c]` as a PMF |
| `PerfectlySecret` | def | Posterior equals prior for all ciphertexts (Def 2.3) |
| `CiphertextIndist` | def | Ciphertext distribution independent of plaintext (Lemma 2.5) |

## Statistics

- **Definitions**: 6
- **Lines of code**: 85
- **Authors**: Samuel Schlesinger
