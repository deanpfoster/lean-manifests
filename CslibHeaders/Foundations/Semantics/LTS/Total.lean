import CslibHeaders.Basic
import Cslib.Foundations.Semantics.LTS.Total

/-! # Total LTS

  ## Vocabulary
  - `Cslib.LTS.Total lts` — class: every state has a derivative for every label
  - `Cslib.LTS.chooseFLTS lts` — choose a sub-FLTS from a total LTS
  - `Cslib.LTS.totalize lts` — add a sink state to make any LTS total
-/

open Cslib Cslib.LTS

ExternalTheorem total_omegaExecution_exists
  := @Cslib.LTS.Total.omegaExecution_exists
  : ∀ {State Label : Type u_1} {lts : LTS State Label} [inst : lts.Total]
    (s : State) (μs : ωSequence Label),
    ∃ ss, lts.OmegaExecution ss μs ∧ ss 0 = s

ExternalTheorem totalize_nonsink_tr_iff
  := @Cslib.LTS.totalize.nonsink_tr_iff
  : ∀ {State Label : Type u_1} {lts : LTS State Label} {μ : Label} {s t : State},
    lts.totalize.Tr (Sum.inl s) μ (Sum.inl t) ↔ lts.Tr s μ t

ExternalTheorem totalize_nonsink_mtr_iff
  := @Cslib.LTS.totalize.nonsink_mtr_iff
  : ∀ {State Label : Type u_1} {lts : LTS State Label} {μs : List Label} {s t : State},
    lts.totalize.MTr (Sum.inl s) μs (Sum.inl t) ↔ lts.MTr s μs t

ExternalTheorem totalize_no_sink_to_nonsink
  := @Cslib.LTS.totalize.no_sink_to_nonsink
  : ∀ {State Label : Type u_1} {lts : LTS State Label} {μs : List Label} {t : State},
    ¬lts.totalize.MTr (Sum.inr ()) μs (Sum.inl t)
