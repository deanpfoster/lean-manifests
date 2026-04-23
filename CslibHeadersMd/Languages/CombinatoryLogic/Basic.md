# CombinatoryLogic.Basic

Defines SKI polynomials (terms with free variables) and the bracket abstraction algorithm. Implements Church booleans, pairs, and derived combinators (B, C, R, Y, Theta).

## Vocabulary

| Name | Kind | Description |
|------|------|-------------|
| `SKI.Polynomial` | inductive | SKI terms with `n` free variables |
| `Polynomial.eval` | def | Substitute a list of terms for free variables |
| `Polynomial.elimVar` | def | Eliminate the outermost variable (bracket abstraction step) |
| `Polynomial.toSKI` | def | Full bracket abstraction |
| `IsBool` | def | A term represents a boolean if `a ⬝ x ⬝ y ↠ (if u then x else y)` |
| `TT`, `FF` | def | Church true (K) and false (K ⬝ I) |
| `MkPair`, `Fst`, `Snd` | def | Church-encoded pairs |
| `Y`, `Th` | def | Curry's and Turing's fixed-point combinators |
| `R`, `B`, `C`, `Del`, `H` | def | Standard combinators |

## Theorems

| # | Name | Signature | Visibility |
|---|------|-----------|------------|
| 1 | `Polynomial.elimVar_correct` | `(Γ.elimVar.eval ys hys ⬝ z) ↠ Γ.eval (ys ++ [z]) ...` | PUBLIC |
| 2 | `Polynomial.toSKI_correct` | `Γ.toSKI.applyList xs ↠ Γ.eval xs hxs` | PUBLIC |
| 3 | `TT_correct` | `IsBool true TT` | PUBLIC |
| 4 | `FF_correct` | `IsBool false FF` | PUBLIC |
| 5 | `neg_correct` | `IsBool ua a → IsBool (¬ ua) (SKI.Neg ⬝ a)` | PUBLIC |
| 6 | `and_correct` | `IsBool ua a → IsBool ub b → IsBool (ua && ub) (SKI.And ⬝ a ⬝ b)` | PUBLIC |
| 7 | `or_correct` | `IsBool ua a → IsBool ub b → IsBool (ua ∥ ub) (SKI.Or ⬝ a ⬝ b)` | PUBLIC |
| 8 | `Y_correct` | `MJoin Red (Y ⬝ f) (f ⬝ (Y ⬝ f))` | PUBLIC |
| 9 | `fixedPoint_correct` | `f.fixedPoint ↠ f ⬝ f.fixedPoint` | PUBLIC |
| 10 | `Th_correct` | `(Th ⬝ f) ↠ f ⬝ (Th ⬝ f)` | PUBLIC |
| 11 | `fst_correct` | `(Fst ⬝ (MkPair ⬝ a ⬝ b)) ↠ a` | PUBLIC |
| 12 | `snd_correct` | `(Snd ⬝ (MkPair ⬝ a ⬝ b)) ↠ b` | PUBLIC |
| 13 | `unpaired_correct` | `(SKI.Unpaired ⬝ f ⬝ (MkPair ⬝ x ⬝ y)) ↠ f ⬝ x ⬝ y` | PUBLIC |
| 14 | `pair_def` | `(SKI.Pair ⬝ f ⬝ g ⬝ x) ↠ MkPair ⬝ (f ⬝ x) ⬝ (g ⬝ x)` | PUBLIC |

## Statistics

- **Theorems/Lemmas**: 14+ (many combinator defs with correctness proofs)
- **Definitions**: ~25
- **Lines of code**: 384
- **Authors**: Thomas Waring
