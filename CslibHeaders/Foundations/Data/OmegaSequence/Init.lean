import CslibHeaders.Basic
import Cslib.Foundations.Data.OmegaSequence.Init

/-! # OmegaSequence.Init: core lemmas for infinite sequences

  ## Vocabulary
  See `OmegaSequence.Defs` for the main definitions.
  This module provides the core equational theory (eta, cons/head/tail,
  drop, map, zip, iterate, append, take, extract).
-/

open Cslib Cslib.ωSequence

-- ════════════════════════════════════════════
-- Structural laws
-- ════════════════════════════════════════════

ExternalTheorem ωSequence_eta
  := @Cslib.ωSequence.eta
  : ∀ {α : Type u_1} (s : ωSequence α), head s ::ω tail s = s

ExternalTheorem ωSequence_ext
  := @Cslib.ωSequence.ext
  : ∀ {α : Type u_1} {s₁ s₂ : ωSequence α}, (∀ n, s₁ n = s₂ n) → s₁ = s₂

-- ════════════════════════════════════════════
-- Take / drop / append
-- ════════════════════════════════════════════

ExternalTheorem ωSequence_append_take_drop
  := @Cslib.ωSequence.append_take_drop
  : ∀ {α : Type u_1} (n : ℕ) (s : ωSequence α),
    ωSequence.appendωSequence (s.take n) (s.drop n) = s

ExternalTheorem ωSequence_take_theorem
  := @Cslib.ωSequence.take_theorem
  : ∀ {α : Type u_1} (s₁ s₂ : ωSequence α),
    (∀ n, s₁.take n = s₂.take n) → s₁ = s₂

-- ════════════════════════════════════════════
-- Extract
-- ════════════════════════════════════════════

ExternalTheorem ωSequence_extract_eq_drop_take
  := @Cslib.ωSequence.extract_eq_drop_take
  : ∀ {α : Type u_1} {xs : ωSequence α} {m n : ℕ},
    xs.extract m n = ωSequence.take (n - m) (xs.drop m)

ExternalTheorem ωSequence_append_extract_extract
  := @Cslib.ωSequence.append_extract_extract
  : ∀ {α : Type u_1} {xs : ωSequence α} {k m n : ℕ},
    k ≤ m → m ≤ n →
    xs.extract k m ++ xs.extract m n = xs.extract k n
