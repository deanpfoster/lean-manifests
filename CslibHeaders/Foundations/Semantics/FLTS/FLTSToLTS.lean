import CslibHeaders.Basic
import Cslib.Foundations.Semantics.FLTS.FLTSToLTS

set_option linter.style.longLine false

/-! # FLTS to LTS conversion

  ## Vocabulary
  - `Cslib.FLTS.toLTS flts` — convert an FLTS to an LTS
  - `Cslib.FLTS.toLTS_deterministic` — the resulting LTS is deterministic
  - `Cslib.FLTS.toLTS_imageFinite` — the resulting LTS is image-finite
-/

open Cslib Cslib.FLTS Cslib.LTS

ExternalTheorem flts_toLTS_tr
  := @Cslib.FLTS.toLTS_tr
  : ∀ {State Label : Type u_1} {flts : FLTS State Label} {s1 : State} {μ : Label} {s2 : State},
    flts.toLTS.Tr s1 μ s2 ↔ flts.tr s1 μ = s2

ExternalTheorem flts_toLTS_mtr
  := @Cslib.FLTS.toLTS_mtr
  : ∀ {State Label : Type u_1} {flts : FLTS State Label} {s1 : State} {μs : List Label} {s2 : State},
    flts.toLTS.MTr s1 μs s2 ↔ flts.mtr s1 μs = s2
