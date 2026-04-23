# Cslib.Foundations.Semantics.LTS.Execution

## Module Summary

Defines finite `Execution` (multi-step transition with explicit intermediate states), proves correspondence with `MTr`, and provides composition and splitting of executions. Also proves `MTr.split` for decomposing multi-step transitions over concatenated labels.

## Vocabulary

| Name | Kind | Description |
|------|------|-------------|
| `LTS.Execution` | def | Multi-step transition with explicit intermediate state list |

## Theorems

### PUBLIC

| # | Name | Signature |
|---|------|-----------|
| 1 | `Execution.nonEmpty_states` | `theorem Execution.nonEmpty_states (h : lts.Execution s1 mus s2 ss) : ss != []` |
| 2 | `Execution.refl` | `theorem Execution.refl (lts : LTS State Label) (s : State) : lts.Execution s [] s [s]` |
| 3 | `Execution.stepL` | `theorem Execution.stepL {lts : LTS State Label} (htr : lts.Tr s1 mu s2) (hexec : lts.Execution s2 mus s3 ss) : lts.Execution s1 (mu :: mus) s3 (s1 :: ss)` |
| 4 | `Execution.of_mTr` | `theorem Execution.of_mTr {lts : LTS State Label} {s1 : State} {mus : List Label} {s2 : State} (h : lts.MTr s1 mus s2) : exists ss : List State, lts.Execution s1 mus s2 ss` |
| 5 | `Execution.to_mTr` | `theorem Execution.to_mTr (hexec : lts.Execution s1 mus s2 ss) : lts.MTr s1 mus s2` |
| 6 | `mTr_iff_execution` | `theorem mTr_iff_execution : lts.MTr s1 mus s2 <-> exists ss : List State, lts.Execution s1 mus s2 ss` |
| 7 | `Execution.comp` | `theorem Execution.comp (h1 : lts.Execution s mus1 r ss1) (h2 : lts.Execution r mus2 t ss2) : lts.Execution s (mus1 ++ mus2) t (ss1 ++ ss2.tail)` |
| 8 | `Execution.split` | `theorem Execution.split (he : lts.Execution s mus t ss) (n : Nat) (hn : n <= mus.length) : lts.Execution s (mus.take n) (ss[n]'...) (ss.take (n + 1)) and lts.Execution (ss[n]'...) (mus.drop n) t (ss.drop n)` |
| 9 | `MTr.split` | `theorem MTr.split {lts : LTS State Label} {s0 : State} {mus1 mus2 : List Label} {s2 : State} (h : lts.MTr s0 (mus1 ++ mus2) s2) : exists s1, lts.MTr s0 mus1 s1 and lts.MTr s1 mus2 s2` |

### INTERNAL

| # | Name | Signature |
|---|------|-----------|
| 1 | `Execution.cons_invert` | `theorem Execution.cons_invert (h : lts.Execution s1 (mu :: mus) s2 (s1 :: ss)) : lts.Execution (ss[0]'...) mus s2 ss` |

## Counts

- **PUBLIC**: 9
- **INTERNAL**: 1
