import CslibHeaders.Basic
import Cslib.Foundations.Semantics.FLTS.Basic

/-! # FLTS: Functional Labelled Transition Systems

  ## Vocabulary
  - `Cslib.FLTS State Label` — structure with transition function `tr : State → Label → State`
  - `FLTS.mtr flts s μs` — extended transition function (fold over label list)
-/

open Cslib Cslib.FLTS

ExternalTheorem flts_mtr_nil_eq
  := @Cslib.FLTS.mtr_nil_eq
  : ∀ {State Label : Type u_1} {flts : FLTS State Label} {s : State},
    flts.mtr s [] = s

ExternalTheorem flts_mtr_concat_eq
  := @Cslib.FLTS.mtr_concat_eq
  : ∀ {State Label : Type u_1} {flts : FLTS State Label} {s : State}
    {μs : List Label} {μ : Label},
    flts.mtr s (μs ++ [μ]) = flts.tr (flts.mtr s μs) μ
