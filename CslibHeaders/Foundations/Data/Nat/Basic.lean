import CslibHeaders.Basic
import Cslib.Foundations.Data.Nat.Segment

/-! # Nat.Segment: segments defined by strictly monotonic functions on Nat

  ## Vocabulary
  - `Nat.segment f k` — the unique `m` such that `f m ≤ k < f (m+1)` (0 for `k < f 0`)
  - `Nat.segment' f k` — helper equal to `segment (f · - f 0) (k - f 0)`
  - `StrictMono f` — `f` is strictly increasing
  - `Set.range f` — the range (image) of `f`
  - `Nat.nth p n` — the `n`-th natural satisfying predicate `p`
  - `Nat.count p n` — count of naturals `< n` satisfying `p`
  - `GaloisConnection f g` — `f a ≤ b ↔ a ≤ g b`
-/

open Function Set Nat

attribute [local instance] Classical.propDecidable

-- ════════════════════════════════════════════
-- Strict monotonicity and infinite ranges
-- ════════════════════════════════════════════

ExternalTheorem strictMono_infinite
  := @Nat.strictMono_infinite
  : ∀ {f : ℕ → ℕ}, StrictMono (α := ℕ) (β := ℕ) f → (Set.range f).Infinite

ExternalTheorem infinite_strictMono
  := @Nat.infinite_strictMono
  : ∀ {ns : Set ℕ}, ns.Infinite →
    ∃ f : ℕ → ℕ, StrictMono f ∧ Set.range f = ns

-- ════════════════════════════════════════════
-- Gaps and nth
-- ════════════════════════════════════════════

ExternalTheorem nth_succ_gap
  := @Nat.nth_succ_gap
  : ∀ {p : ℕ → Prop}, (setOf p).Infinite →
    ∀ (n k : ℕ), k < Nat.nth p (n + 1) - Nat.nth p n →
    k > 0 → ¬p (k + Nat.nth p n)

ExternalTheorem nth_of_strictMono
  := @Nat.nth_of_strictMono
  : ∀ {f : ℕ → ℕ}, StrictMono f →
    ∀ (n : ℕ), f n = Nat.nth (fun x => x ∈ Set.range f) n

ExternalTheorem count_notMem_range_pos
  := @Nat.count_notMem_range_pos
  : ∀ {f : ℕ → ℕ}, f 0 = 0 →
    ∀ n ∉ Set.range f,
    Nat.count (fun x => x ∈ Set.range f) n > 0

ExternalTheorem strictMono_range_gap
  := @Nat.strictMono_range_gap
  : ∀ {f : ℕ → ℕ}, StrictMono f →
    ∀ {m k : ℕ}, f m < k → k < f (m + 1) → k ∉ Set.range f

-- ════════════════════════════════════════════
-- Segment: basic properties (f 0 = 0 case)
-- ════════════════════════════════════════════

ExternalTheorem segment_idem
  := @Nat.segment_idem
  : ∀ {f : ℕ → ℕ}, StrictMono f →
    ∀ (k : ℕ), Nat.segment f (f k) = k

ExternalTheorem segment_pre_zero
  := @Nat.segment_pre_zero
  : ∀ {f : ℕ → ℕ}, StrictMono f →
    ∀ {k : ℕ}, k < f 0 → Nat.segment f k = 0

ExternalTheorem segment_zero
  := @Nat.segment_zero
  : ∀ {f : ℕ → ℕ}, StrictMono f →
    f 0 = 0 → Nat.segment f 0 = 0

ExternalTheorem segment_plus_one
  := @Nat.segment_plus_one
  : ∀ {f : ℕ → ℕ}, f 0 = 0 →
    ∀ (k : ℕ), Nat.segment f k + 1 = Nat.count (fun x => x ∈ Set.range f) (k + 1)

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

-- ════════════════════════════════════════════
-- Segment: general case (arbitrary f 0)
-- ════════════════════════════════════════════

ExternalTheorem base_zero_strictMono
  := @Nat.base_zero_strictMono
  : ∀ {f : ℕ → ℕ}, StrictMono f →
    StrictMono fun x => f x - f 0

ExternalTheorem segment'_eq_segment
  := @Nat.segment'_eq_segment
  : ∀ {f : ℕ → ℕ}, StrictMono f →
    Nat.segment' f = Nat.segment f

ExternalTheorem segment_zero'
  := @Nat.segment_zero'
  : ∀ {f : ℕ → ℕ}, StrictMono f →
    ∀ {k : ℕ}, k ≤ f 0 → Nat.segment f k = 0

ExternalTheorem segment_upper_bound'
  := @Nat.segment_upper_bound'
  : ∀ {f : ℕ → ℕ}, StrictMono f →
    ∀ {k : ℕ}, f 0 ≤ k → k < f (Nat.segment f k + 1)

ExternalTheorem segment_lower_bound'
  := @Nat.segment_lower_bound'
  : ∀ {f : ℕ → ℕ}, StrictMono f →
    ∀ {k : ℕ}, f 0 ≤ k → f (Nat.segment f k) ≤ k
