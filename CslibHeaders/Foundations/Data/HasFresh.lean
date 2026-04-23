import CslibHeaders.Basic
import Cslib.Foundations.Data.HasFresh

/-! # HasFresh: computable fresh element generation

  ## Vocabulary
  - `Cslib.HasFresh α` — class: given any `Finset α`, compute an element not in it
  - `Cslib.HasFresh.fresh s` — a fresh element not in `s`
  - `Cslib.HasFresh.fresh_notMem s` — proof that `fresh s ∉ s`
  - `Cslib.HasFresh.fresh_exists s` — existential form: `∃ a, a ∉ s`
  - `Cslib.HasFresh.ofNatEmbed` — construct from a `ℕ`-embedding
  - `Cslib.HasFresh.ofSucc` — construct from a successor function
-/

open Cslib

-- ════════════════════════════════════════════
-- Core properties
-- ════════════════════════════════════════════

ExternalTheorem fresh_exists
  := @Cslib.HasFresh.fresh_exists
  : ∀ {α : Type u_1} [inst : HasFresh α] (s : Finset α), ∃ a, a ∉ s

-- HasFresh implies infinite
CheckTheorem @Cslib.HasFresh.to_infinite
  : ∀ (α : Type u_1) [inst : HasFresh α], Infinite α

-- Infinite implies (noncomputable) HasFresh
CheckTheorem @Cslib.HasFresh.of_infinite
  : ∀ (α : Type u_1) [inst : Infinite α], HasFresh α
