import CslibHeaders.Basic
import Cslib.Foundations.Semantics.FLTS.Prod

/-! # FLTS product construction

  ## Vocabulary
  - `Cslib.FLTS.prod flts1 flts2` — product of two FLTSs with the same label type
-/

open Cslib Cslib.FLTS

ExternalTheorem flts_prod_mtr_eq
  := @Cslib.FLTS.prod_mtr_eq
  : ∀ {Label : Type u_1} {State1 : Type u_2} {State2 : Type u_3}
    (flts1 : FLTS State1 Label) (flts2 : FLTS State2 Label)
    (s : State1 × State2) (μs : List Label),
    (flts1.prod flts2).mtr s μs = (flts1.mtr s.fst μs, flts2.mtr s.snd μs)
