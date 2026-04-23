import CslibHeaders.Basic
import Cslib.Foundations.Semantics.LTS.Execution

/-! # LTS Finite Executions

  ## Vocabulary
  - `Cslib.LTS.Execution lts s1 μs s2 ss` — multistep transition with intermediate states `ss`
-/

open Cslib Cslib.LTS

ExternalTheorem execution_refl
  := @Cslib.LTS.Execution.refl
  : ∀ {State Label : Type u_1} (lts : LTS State Label) (s : State),
    lts.Execution s [] s [s]

ExternalTheorem mTr_iff_execution
  := @Cslib.LTS.mTr_iff_execution
  : ∀ {State Label : Type u_1} {lts : LTS State Label} {s1 : State}
    {μs : List Label} {s2 : State},
    lts.MTr s1 μs s2 ↔ ∃ ss, lts.Execution s1 μs s2 ss

ExternalTheorem execution_comp
  := @Cslib.LTS.Execution.comp
  : ∀ {State Label : Type u_1} {lts : LTS State Label}
    {s r t : State} {μs1 μs2 : List Label} {ss1 ss2 : List State},
    lts.Execution s μs1 r ss1 → lts.Execution r μs2 t ss2 →
    lts.Execution s (μs1 ++ μs2) t (ss1 ++ ss2.tail)

ExternalTheorem mTr_split
  := @Cslib.LTS.MTr.split
  : ∀ {State Label : Type u_1} {lts : LTS State Label}
    {s0 : State} {μs1 μs2 : List Label} {s2 : State},
    lts.MTr s0 (μs1 ++ μs2) s2 → ∃ s1, lts.MTr s0 μs1 s1 ∧ lts.MTr s1 μs2 s2
