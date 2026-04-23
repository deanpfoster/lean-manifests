import CslibHeaders.Basic
import Cslib.Foundations.Data.OmegaSequence.InfOcc

/-! # OmegaSequence.InfOcc: infinite occurrences in sequences

  ## Vocabulary
  - `ωSequence.infOcc xs` — the set of elements appearing infinitely often in `xs`
-/

open Cslib Cslib.ωSequence Filter

ExternalTheorem ωSequence_frequently_iff_strictMono
  := @Cslib.ωSequence.frequently_iff_strictMono
  : ∀ {p : ℕ → Prop},
    (∃ᶠ n in atTop, p n) ↔ ∃ f : ℕ → ℕ, StrictMono f ∧ ∀ m, p (f m)

ExternalTheorem ωSequence_frequently_in_finite_type
  := @Cslib.ωSequence.frequently_in_finite_type
  : ∀ {α : Type u_1} [inst : Finite α] {s : Set α} {xs : ωSequence α},
    (∃ᶠ k in atTop, xs k ∈ s) ↔ ∃ x ∈ s, ∃ᶠ k in atTop, xs k = x

ExternalTheorem ωSequence_frequently_in_strictMono
  := @Cslib.ωSequence.frequently_in_strictMono
  : ∀ {p : ℕ → Prop} {f : ℕ → ℕ},
    StrictMono f → (∃ᶠ k in atTop, p k) →
    ∃ᶠ n in atTop, ∃ k, k < f (n + 1) - f n ∧ p (f n + k)
