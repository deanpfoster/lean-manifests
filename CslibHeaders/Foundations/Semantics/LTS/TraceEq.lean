import CslibHeaders.Basic
import Cslib.Foundations.Semantics.LTS.TraceEq

/-! # Trace Equivalence for LTS

  ## Vocabulary
  - `Cslib.LTS.traces lts s` — the set of traces (label sequences) of state `s`
  - `Cslib.LTS.TraceEq lts₁ lts₂ s₁ s₂` — `s₁` and `s₂` have the same traces
  - `s₁ ~tr[lts₁,lts₂] s₂` — notation for trace equivalence
  - `Cslib.LTS.HomTraceEq lts` — homogeneous trace equivalence
-/

open Cslib Cslib.LTS

ExternalTheorem homTraceEq_eqv
  := @Cslib.LTS.HomTraceEq.eqv
  : ∀ {State : Type u_1} {Label : Type u_2} {lts : LTS State Label},
    Equivalence (HomTraceEq lts)

ExternalTheorem traceEq_deterministic_isSimulation
  := @Cslib.LTS.TraceEq.deterministic_isSimulation
  : ∀ {State₁ : Type u_1} {Label : Type u_2} {State₂ : Type u_3}
    {lts₁ : LTS State₁ Label} {lts₂ : LTS State₂ Label}
    [inst₁ : lts₁.Deterministic] [inst₂ : lts₂.Deterministic],
    IsSimulation lts₁ lts₂ (TraceEq lts₁ lts₂)
