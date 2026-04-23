import CslibHeaders.Basic
import Cslib.Foundations.Semantics.LTS.HasTau

set_option linter.style.longLine false

/-! # LTS with internal transition tau

  ## Vocabulary
  - `Cslib.HasTau Label` — class providing `τ : Label`
  - `Cslib.LTS.τSTr lts` — saturated tau-transition relation (reflexive-transitive closure)
  - `Cslib.LTS.STr lts` — saturated transition relation
  - `Cslib.LTS.saturate lts` — the LTS obtained by saturating transitions
  - `Cslib.LTS.τClosure lts S` — tau-closure of a set of states
-/

open Cslib Cslib.LTS

ExternalTheorem sTr_τSTr
  := @Cslib.LTS.sTr_τSTr
  : ∀ {Label : Type u_1} {State : Type u_2} {s s' : State}
    [inst : HasTau Label] (lts : LTS State Label),
    lts.STr s HasTau.τ s' ↔ lts.τSTr s s'

ExternalTheorem sTr_single
  := @Cslib.LTS.STr.single
  : ∀ {Label : Type u_1} {State : Type u_2} {s : State} {μ : Label} {s' : State}
    [inst : HasTau Label] (lts : LTS State Label),
    lts.Tr s μ s' → lts.STr s μ s'

ExternalTheorem sTr_comp
  := @Cslib.LTS.STr.comp
  : ∀ {Label : Type u_1} {State : Type u_2} {s1 s2 : State} {μ : Label} {s3 s4 : State}
    [inst : HasTau Label] (lts : LTS State Label),
    lts.STr s1 HasTau.τ s2 → lts.STr s2 μ s3 → lts.STr s3 HasTau.τ s4 →
    lts.STr s1 μ s4

ExternalTheorem saturate_τSTr_τSTr
  := @Cslib.LTS.saturate_τSTr_τSTr
  : ∀ {Label : Type u_1} {State : Type u_2} {s : State}
    [inst : HasTau Label] (lts : LTS State Label),
    lts.saturate.τSTr s = lts.τSTr s
