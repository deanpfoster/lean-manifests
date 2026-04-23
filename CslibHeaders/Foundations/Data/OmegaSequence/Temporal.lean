import CslibHeaders.Basic
import Cslib.Foundations.Data.OmegaSequence.Temporal

/-! # OmegaSequence.Temporal: temporal reasoning over infinite sequences

  ## Vocabulary
  - `ωSequence.Step xs p q` — whenever `p` holds at position `k`, `q` holds at `k+1`
  - `ωSequence.LeadsTo xs p q` — whenever `p` holds, `q` eventually holds
-/

open Cslib Cslib.ωSequence Filter

ExternalTheorem step_leadsTo
  := @Cslib.ωSequence.step_leadsTo
  : ∀ {α : Type u_1} {xs : ωSequence α} {p q : Set α},
    xs.Step p q → xs.LeadsTo p q

ExternalTheorem leadsTo_trans
  := @Cslib.ωSequence.leadsTo_trans
  : ∀ {α : Type u_1} {xs : ωSequence α} {p q r : Set α},
    xs.LeadsTo p q → xs.LeadsTo q r → xs.LeadsTo p r

ExternalTheorem until_frequently_not_leadsTo
  := @Cslib.ωSequence.until_frequently_not_leadsTo
  : ∀ {α : Type u_1} {xs : ωSequence α} {p q : Set α},
    xs.Step (p ∩ qᶜ) p → (∃ᶠ k in atTop, xs k ∉ p) → xs.LeadsTo p q

ExternalTheorem frequently_leadsTo_frequently
  := @Cslib.ωSequence.frequently_leadsTo_frequently
  : ∀ {α : Type u_1} {xs : ωSequence α} {p q : Set α},
    (∃ᶠ k in atTop, xs k ∈ p) → xs.LeadsTo p q → (∃ᶠ k in atTop, xs k ∈ q)
