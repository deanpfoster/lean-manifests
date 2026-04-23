import CslibHeaders.Basic
import Cslib.Foundations.Data.Set.Saturation

/-! # Set.Saturation: saturation of sets by indexed families

  ## Vocabulary
  - `Set.Saturates f s` — `f i ⊆ s` whenever `f i ∩ s` is nonempty
  - `sᶜ` — complement of set `s`
  - `⋃ i, f i` — indexed union
  - `Set.univ` — the universal set
-/

open Set

-- ════════════════════════════════════════════
-- Saturation
-- ════════════════════════════════════════════

ExternalTheorem saturates_compl
  := @Set.saturates_compl
  : ∀ {ι : Type u_1} {α : Type u_2} {f : ι → Set α} {s : Set α},
    Set.Saturates f s → Set.Saturates f sᶜ

ExternalTheorem saturates_eq_biUnion
  := @Set.saturates_eq_biUnion
  : ∀ {ι : Type u_1} {α : Type u_2} {f : ι → Set α} {s : Set α},
    Set.Saturates f s →
    ⋃ i, f i = Set.univ →
    s = ⋃ i ∈ {i | (f i ∩ s).Nonempty}, f i
