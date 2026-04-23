# CombinatoryLogic.Recursion

Implements general recursion in SKI: Church numerals, predecessor, primitive recursion, mu-recursion (unbounded search), arithmetic (add, mul, sub, comparison), integer square root, and Nat pairing/unpairing.

## Vocabulary

| Name | Kind | Description |
|------|------|-------------|
| `Church` | def | Church numeral as a function: `Church n f x` |
| `IsChurch` | def | `a` represents `n` if `a ⬝ f ⬝ x ↠ Church n f x` |
| `SKI.Zero`, `SKI.Succ` | def | Church zero and successor |
| `Pred` | def | Church predecessor |
| `IsZero` | def | Tests if a Church numeral is zero |
| `Rec` | def | Primitive recursion combinator |
| `RFind` | def | Unbounded root-finding (mu-recursion) |
| `Sqrt` | def | Integer square root |
| `NatPair`, `NatUnpairLeft`, `NatUnpairRight` | def | Nat pairing matching Mathlib's `Nat.pair` |

## Theorems

| # | Name | Signature | Visibility |
|---|------|-----------|------------|
| 1 | `zero_correct` | `IsChurch 0 SKI.Zero` | PUBLIC |
| 2 | `succ_correct` | `IsChurch n a → IsChurch (n+1) (SKI.Succ ⬝ a)` | PUBLIC |
| 3 | `pred_correct` | `IsChurch n a → IsChurch n.pred (Pred ⬝ a)` | PUBLIC |
| 4 | `rec_zero` | `IsChurch 0 a → (Rec ⬝ x ⬝ g ⬝ a) ↠ x` | PUBLIC |
| 5 | `rec_succ` | `IsChurch (n+1) a → (Rec ⬝ x ⬝ g ⬝ a) ↠ g ⬝ a ⬝ (Rec ⬝ x ⬝ g ⬝ (Pred ⬝ a))` | PUBLIC |
| 6 | `RFind_correct` | `(hf) → fNat n = 0 → (∀ i < n, fNat i ≠ 0) → IsChurch n (RFind ⬝ f)` | PUBLIC |
| 7 | `add_correct` | `IsChurch n a → IsChurch m b → IsChurch (n+m) (SKI.Add ⬝ a ⬝ b)` | PUBLIC |
| 8 | `mul_correct` | `IsChurch n a → IsChurch m b → IsChurch (n*m) (SKI.Mul ⬝ a ⬝ b)` | PUBLIC |
| 9 | `sub_correct` | `IsChurch n a → IsChurch m b → IsChurch (n-m) (SKI.Sub ⬝ a ⬝ b)` | PUBLIC |
| 10 | `le_correct` | `IsChurch n a → IsChurch m b → IsBool (n ≤ m) (SKI.LE ⬝ a ⬝ b)` | PUBLIC |
| 11 | `sqrt_correct` | `IsChurch n cn → IsChurch (Nat.sqrt n) (Sqrt ⬝ cn)` | PUBLIC |
| 12 | `natPair_correct` | `IsChurch a ca → IsChurch b cb → IsChurch (Nat.pair a b) (NatPair ⬝ ca ⬝ cb)` | PUBLIC |
| 13 | `natUnpairLeft_correct` | `IsChurch n cn → IsChurch (Nat.unpair n).1 (NatUnpairLeft ⬝ cn)` | PUBLIC |
| 14 | `natUnpairRight_correct` | `IsChurch n cn → IsChurch (Nat.unpair n).2 (NatUnpairRight ⬝ cn)` | PUBLIC |

## Statistics

- **Theorems/Lemmas**: 14 major correctness theorems
- **Lines of code**: 570
- **Authors**: Thomas Waring, Jesse Alama
