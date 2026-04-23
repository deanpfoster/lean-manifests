import CslibHeaders.Basic
import Cslib.Foundations.Data.Nat.Segment

/-! # Nat.Segment: segments defined by strictly monotonic functions on Nat

  ## Vocabulary
  - `Nat.segment f k` — the unique `m` such that `f m <= k < f (m+1)` (0 for `k < f 0`)
  - `Nat.segment' f k` — helper equal to `segment (f . - f 0) (k - f 0)`
  - `StrictMono f` — `f` is strictly increasing
  - `GaloisConnection f g` — `f a <= b <-> a <= g b`
-/

open Function Set Nat

attribute [local instance] Classical.propDecidable

ExternalTheorem strictMono_infinite
  := @Nat.strictMono_infinite
  : ∀ {f : ℕ → ℕ}, StrictMono f → (Set.range f).Infinite

ExternalTheorem segment_idem
  := @Nat.segment_idem
  : ∀ {f : ℕ → ℕ}, StrictMono f → ∀ (k : ℕ), Nat.segment f (f k) = k

ExternalTheorem segment_upper_bound
  := @Nat.segment_upper_bound
  : ∀ {f : ℕ → ℕ}, StrictMono f → f 0 = 0 →
    ∀ (k : ℕ), k < f (Nat.segment f k + 1)

ExternalTheorem segment_lower_bound
  := @Nat.segment_lower_bound
  : ∀ {f : ℕ → ℕ}, StrictMono f → f 0 = 0 →
    ∀ (k : ℕ), f (Nat.segment f k) ≤ k

ExternalTheorem segment_range_val
  := @Nat.segment_range_val
  : ∀ {f : ℕ → ℕ}, StrictMono f →
    ∀ {m k : ℕ}, f m ≤ k → k < f (m + 1) → Nat.segment f k = m

ExternalTheorem segment_galois_connection
  := @Nat.segment_galois_connection
  : ∀ {f : ℕ → ℕ}, StrictMono f → f 0 = 0 →
    GaloisConnection f (Nat.segment f)
