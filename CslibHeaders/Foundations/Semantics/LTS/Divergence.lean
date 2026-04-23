import CslibHeaders.Basic
import Cslib.Foundations.Semantics.LTS.Divergence

/-! # LTS Divergence

  ## Vocabulary
  - `Cslib.LTS.DivergentTrace μs` — every label in `μs` is `τ`
  - `Cslib.LTS.Divergent lts s` — there is a divergent execution from `s`
  - `Cslib.LTS.DivergenceFree lts` — class: no state is divergent
-/

open Cslib Cslib.LTS

ExternalTheorem divergentTrace_drop
  := @Cslib.LTS.divergentTrace_drop
  : ∀ {Label : Type u_1} [inst : HasTau Label] {μs : ωSequence Label},
    DivergentTrace μs → ∀ (n : ℕ), DivergentTrace (μs.drop n)
