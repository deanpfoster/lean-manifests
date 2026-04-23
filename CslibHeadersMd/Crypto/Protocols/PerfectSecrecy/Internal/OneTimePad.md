# PerfectSecrecy.Internal.OneTimePad

Internal proof that the OTP ciphertext distribution is uniform regardless of message.

## Theorems

| # | Name | Signature | Visibility |
|---|------|-----------|------------|
| 1 | `otp_ciphertextDist_eq_uniform` | `(PMF.uniformOfFintype _).bind (fun k => PMF.pure (k ^^^ m)) = PMF.uniformOfFintype _` | INTERNAL |

## Statistics

- **Theorems/Lemmas**: 1
- **Lines of code**: 39
- **Authors**: Samuel Schlesinger
