import CslibHeaders.Basic
import Cslib.Foundations.Semantics.FLTS.LTSToFLTS

set_option linter.style.longLine false

/-! # LTS to FLTS (subset construction)

  ## Vocabulary
  - `Cslib.LTS.toFLTS lts` — convert an LTS to an FLTS via the subset/powerset construction
-/

open Cslib Cslib.LTS

ExternalTheorem lts_toFLTS_mem_tr
  := @Cslib.LTS.toFLTS_mem_tr
  : ∀ {State Label : Type u_1} {lts : LTS State Label} {S : Set State} {s' : State} {μ : Label},
    s' ∈ lts.toFLTS.tr S μ ↔ ∃ s ∈ S, lts.Tr s μ s'

ExternalTheorem lts_toFLTS_mem_mtr
  := @Cslib.LTS.toFLTS_mem_mtr
  : ∀ {State Label : Type u_1} {lts : LTS State Label} {S : Set State} {s' : State} {μs : List Label},
    s' ∈ lts.toFLTS.mtr S μs ↔ ∃ s ∈ S, lts.MTr s μs s'

ExternalTheorem lts_toFLTS_mtr_setImageMultistep
  := @Cslib.LTS.toFLTS_mtr_setImageMultistep
  : ∀ {State Label : Type u_1} {lts : LTS State Label},
    lts.toFLTS.mtr = lts.setImageMultistep
