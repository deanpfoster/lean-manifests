# Cslib.Computability.Automata.NA.Total

## Summary
Defines totalization of nondeterministic automata by adding a sink state, and proves that the totalized NA accepts the same language of finite words as the original.

## Vocabulary
| Name | Kind | Description |
|------|------|-------------|
| `NA.totalize` | def | Makes an NA total by adding a sink state via `LTS.totalize` |

## Theorems

| # | Name | Signature | Visibility |
|---|------|-----------|------------|
| 1 | `totalize_run_mtr` | `{xs : ωSequence Symbol} {ss : ωSequence (State ⊕ Unit)} {n : ℕ} (h : na.totalize.Run xs ss) (hl : (ss n).isLeft) : ∃ s t, na.MTr s (xs.take n) t ∧ s ∈ na.start ∧ ss 0 = inl s ∧ ss n = inl t` | PUBLIC |
| 2 | `totalize_mtr_run` | `[Inhabited Symbol] {xl : List Symbol} {s t : State} (hs : s ∈ na.start) (hm : na.MTr s xl t) : ∃ xs ss, na.totalize.Run (xl ++ω xs) ss ∧ ss 0 = inl s ∧ ss xl.length = inl t` | PUBLIC |
| 3 | `FinAcc.totalize_language_eq` | `{na : FinAcc State Symbol} : language (FinAcc.mk na.totalize (inl '' na.accept)) = language na` | PUBLIC |

## Statistics
- Theorems/Lemmas: 3
- Definitions: 1
- Lines of code: 63
- Imports: Cslib.Computability.Automata.NA.Basic, Cslib.Foundations.Semantics.LTS.Total
