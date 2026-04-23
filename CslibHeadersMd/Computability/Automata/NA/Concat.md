# Cslib.Computability.Automata.NA.Concat

## Summary
Defines the concatenation of nondeterministic automata (an accepting NA followed by another NA) and proves that the Buchi language of the concatenation equals the product of languages. Also defines finite concatenation (`finConcat`) using totalized automata.

## Vocabulary
| Name | Kind | Description |
|------|------|-------------|
| `NA.concat` | def | Concatenation of FinAcc NA1 and NA2 via sum states |
| `NA.FinAcc.finConcat` | def | Finite concatenation using totalized versions |

## Theorems

| # | Name | Signature | Visibility |
|---|------|-----------|------------|
| 1 | `concat_start_right` | `(hc : (concat na1 na2).Run xs ss) (hr : (ss 0).isRight) : [] ∈ language na1` | INTERNAL |
| 2 | `concat_run_left` | `(hc : (concat na1 na2).Run xs ss) (n : ℕ) (hl : ∀ k ≤ n, (ss k).isLeft) : ∃ s1 t1, na1.MTr s1 (xs.take n) t1 ∧ s1 ∈ na1.start ∧ ss 0 = inl s1 ∧ ss n = inl t1` | INTERNAL |
| 3 | `concat_run_left_right` | `(hc : (concat na1 na2).Run xs ss) (n : ℕ) (hn : 0 < n) (hl : ∀ k < n, (ss k).isLeft) (hr : (ss n).isRight) : (xs.take n) ∈ language na1` | INTERNAL |
| 4 | `concat_run_right` | `(hc : (concat na1 na2).Run xs ss) (n : ℕ) (hl : ∀ k < n, (ss k).isLeft) (hr : (ss n).isRight) : ∃ ss2, na2.Run (xs.drop n) ss2 ∧ ss.drop n = ss2.map inr` | INTERNAL |
| 5 | `concat_run_proj` | `(hc : (concat na1 na2).Run xs ss) (hr : (ss k).isRight) : ∃ n, n ≤ k ∧ xs.take n ∈ language na1 ∧ ∃ ss2, na2.Run (xs.drop n) ss2 ∧ ss.drop n = ss2.map inr` | PUBLIC |
| 6 | `concat_run_exists` | `(h1 : xs1 ∈ language na1) (h2 : na2.Run xs2 ss2) : ∃ ss, (concat na1 na2).Run (xs1 ++ω xs2) ss ∧ ss.drop xs1.length = ss2.map inr` | PUBLIC |
| 7 | `Buchi.concat_language_eq` | `{acc2 : Set State2} : language (Buchi.mk (concat na1 na2) (inr '' acc2)) = language na1 * language (Buchi.mk na2 acc2)` | PUBLIC |
| 8 | `FinAcc.finConcat_language_eq` | `[Inhabited Symbol] : language (FinAcc.mk (finConcat na1 na2) (inr '' (inl '' na2.accept))) = language na1 * language na2` | PUBLIC |

## Instances

| # | Name | Signature | Visibility |
|---|------|-----------|------------|
| 1 | `(finConcat na1 na2).Total` | totality of `finConcat` | PUBLIC |

## Statistics
- Theorems/Lemmas: 8
- Definitions: 2
- Instances: 1
- Lines of code: 191
- Imports: Cslib.Computability.Automata.NA.Total, Cslib.Foundations.Data.OmegaSequence.Temporal
