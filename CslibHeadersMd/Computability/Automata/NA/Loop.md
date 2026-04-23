# Cslib.Computability.Automata.NA.Loop

## Summary
Defines the loop construction on nondeterministic automata, enabling omega-iteration. The loop automaton can nondeterministically restart from an accepting state. Proves the Buchi language of the loop equals the omega-power of the original language, and that `finLoop` accepts the Kleene star.

## Vocabulary
| Name | Kind | Description |
|------|------|-------------|
| `FinAcc.loop` | def | Loop construction on FinAcc NA using a dummy unit state |
| `FinAcc.finLoop` | def | Loop construction applied to the totalized version |

## Theorems

| # | Name | Signature | Visibility |
|---|------|-----------|------------|
| 1 | `loop_run_left_left` | `(h : na.loop.Run xs ss) (h1 : (ss 1).isLeft) : [xs 0] ∈ language na` | INTERNAL |
| 2 | `loop_run_left_right` | `(h : na.loop.Run xs ss) (n : ℕ) (h1 : 0 < n) (h2 : ...) : ∃ s t, na.MTr s (xs.take n) t ∧ s ∈ na.start ∧ ss n = inr t` | INTERNAL |
| 3 | `loop_run_left_right_left` | `(h : na.loop.Run xs ss) (n : ℕ) (h1 : 0 < n ∧ (ss n).isLeft) (h2 : ...) : xs.take n ∈ language na` | INTERNAL |
| 4 | `loop_run_from_left` | `(h : na.loop.Run xs ss) (n : ℕ) (h1 : (ss n).isLeft) : na.loop.Run (xs.drop n) (ss.drop n)` | INTERNAL |
| 5 | `loop_run_one_iter` | `(h : na.loop.Run xs ss) (h1 : 0 < k) (h2 : (ss k).isLeft) : ∃ n, n ≤ k ∧ xs.take n ∈ language na - 1 ∧ na.loop.Run (xs.drop n) (ss.drop n)` | PUBLIC |
| 6 | `loop_fin_run_exists` | `(h : xl ∈ language na) : ∃ sl : List (Unit ⊕ State), ∃ _ : sl.length = xl.length + 1, sl[0] = inl () ∧ sl[xl.length] = inl () ∧ ∀ k, (_ : k < xl.length) → na.loop.Tr sl[k] xl[k] sl[k + 1]` | PUBLIC |
| 7 | `loop_fin_run_mtr` | `(h : xl ∈ language na) : na.loop.MTr (inl ()) xl (inl ())` | PUBLIC |
| 8 | `loop_run_exists` | `[Inhabited Symbol] (h : ∀ k, (xls k) ∈ language na - 1) : ∃ ss, na.loop.Run xls.flatten ss ∧ ∀ k, ss (xls.cumLen k) = inl ()` | PUBLIC |
| 9 | `Buchi.loop_language_eq` | `[Inhabited Symbol] : language (Buchi.mk na.loop {inl ()}) = (language na)^ω` | PUBLIC |
| 10 | `FinAcc.loop_language_eq` | `[Inhabited Symbol] (h : ¬ language na = 0) : language (FinAcc.mk na.finLoop {inl ()}) = (language na)∗` | PUBLIC |

## Instances

| # | Name | Signature | Visibility |
|---|------|-----------|------------|
| 1 | `na.finLoop.Total` | `[Nonempty na.start]` totality of finLoop | PUBLIC |

## Statistics
- Theorems/Lemmas: 10 (6 public, 4 internal)
- Definitions: 2
- Instances: 1
- Lines of code: 223
- Imports: Cslib.Computability.Automata.NA.Total, Cslib.Foundations.Data.OmegaSequence.Temporal
