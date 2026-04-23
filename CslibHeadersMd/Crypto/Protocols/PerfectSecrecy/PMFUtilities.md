# PerfectSecrecy.PMFUtilities

General PMF lemmas for pairing binds and posterior distributions. Intended for upstream to Mathlib.

## Vocabulary

| Name | Kind | Description |
|------|------|-------------|
| `posteriorDist` | def | Posterior distribution `Pr[A=a | B=b]` as a PMF |

## Theorems

| # | Name | Signature | Visibility |
|---|------|-----------|------------|
| 1 | `bind_pair_apply` | `(p.bind ...) (a,b) = p a * f a b` | PUBLIC |
| 2 | `bind_pair_tsum_fst` | marginalizing over first component | PUBLIC |
| 3 | `posterior_hasSum` | posterior probabilities sum to 1 | PUBLIC |

## Statistics

- **Theorems/Lemmas**: 3
- **Lines of code**: 91
- **Authors**: Samuel Schlesinger
