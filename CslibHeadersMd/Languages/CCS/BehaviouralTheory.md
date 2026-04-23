# CCS.BehaviouralTheory

Proves that bisimilarity is a congruence in CCS and establishes standard algebraic laws of bisimilarity for parallel composition and nondeterministic choice.

## Vocabulary

| Name | Kind | Description |
|------|------|-------------|
| `CCS.bisimilarityCongruence` | instance | `Congruence` instance: bisimilarity is a congruence in CCS |

## Theorems

| # | Name | Signature | Visibility |
|---|------|-----------|------------|
| 1 | `bisimilarity_par_nil` | `(par p nil) ~[lts] p` | PUBLIC |
| 2 | `bisimilarity_par_comm` | `(par p q) ~[lts] (par q p)` | PUBLIC |
| 3 | `bisimilarity_nil_par` | `(par nil p) ~[lts] p` | PUBLIC |
| 4 | `bisimilarity_par_assoc` | `(par p (par q r)) ~[lts] (par (par p q) r)` | PUBLIC |
| 5 | `bisimilarity_choice_nil` | `(choice p nil) ~[lts] p` | PUBLIC |
| 6 | `bisimilarity_choice_idem` | `(choice p p) ~[lts] p` | PUBLIC |
| 7 | `bisimilarity_choice_comm` | `(choice p q) ~[lts] (choice q p)` | PUBLIC |
| 8 | `bisimilarity_choice_assoc` | `(choice p (choice q r)) ~[lts] (choice (choice p q) r)` | PUBLIC |
| 9 | `bisimilarity_congr_pre` | `(p ~[lts] q) → (pre μ p) ~[lts] (pre μ q)` | PUBLIC |
| 10 | `bisimilarity_congr_res` | `(p ~[lts] q) → (res a p) ~[lts] (res a q)` | PUBLIC |
| 11 | `bisimilarity_congr_choice` | `(p ~[lts] q) → (choice p r) ~[lts] (choice q r)` | PUBLIC |
| 12 | `bisimilarity_congr_par` | `(p ~[lts] q) → (par p r) ~[lts] (par q r)` | PUBLIC |
| 13 | `bisimilarity_is_congruence` | `(p ~[lts] q) → (c.fill p) ~[lts] (c.fill q)` | PUBLIC |

## Statistics

- **Theorems/Lemmas**: 13
- **Definitions**: 1 instance
- **Lines of code**: 454
- **Authors**: Fabrizio Montesi
