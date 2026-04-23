import CslibHeaders.Basic
import Cslib.Foundations.Semantics.LTS.OmegaExecution

/-! # LTS Infinite (Omega) Executions

  ## Vocabulary
  - `Cslib.LTS.OmegaExecution lts ss μs` — `ss` and `μs` form an infinite execution in `lts`
-/

open Cslib Cslib.LTS Cslib.ωSequence

ExternalTheorem omegaExecution_extract_mTr
  := @Cslib.LTS.OmegaExecution.extract_mTr
  : ∀ {State : Type u_1} {Label : Type u_2} {lts : LTS State Label}
    {ss : ωSequence State} {μs : ωSequence Label},
    lts.OmegaExecution ss μs → ∀ {n m : ℕ}, n ≤ m →
    lts.MTr (ss n) (μs.extract n m) (ss m)

ExternalTheorem omegaExecution_cons
  := @Cslib.LTS.OmegaExecution.cons
  : ∀ {State : Type u_1} {Label : Type u_2} {lts : LTS State Label}
    {s : State} {μ : Label} {t : State} {ss : ωSequence State} {μs : ωSequence Label},
    lts.Tr s μ t → lts.OmegaExecution ss μs → ss 0 = t →
    lts.OmegaExecution (s ::ω ss) (μ ::ω μs)
