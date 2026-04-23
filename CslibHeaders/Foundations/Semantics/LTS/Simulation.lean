import CslibHeaders.Basic
import Cslib.Foundations.Semantics.LTS.Simulation

set_option linter.style.longLine false

/-! # Simulation and Similarity for LTS

  ## Vocabulary
  - `Cslib.LTS.IsSimulation lts₁ lts₂ r` — `r` is a simulation
  - `Cslib.LTS.Similarity lts₁ lts₂ s₁ s₂` — `s₁` is similar to `s₂`
  - `s₁ ≤[lts₁,lts₂] s₂` — notation for similarity
  - `Cslib.LTS.SimulationEquiv lts₁ lts₂` — mutual similarity
  - `s₁ ≤≥[lts₁,lts₂] s₂` — notation for simulation equivalence
  - `Cslib.LTS.HomSimulationEquiv.eqv` — homogeneous simulation equivalence is an equivalence
-/

open Cslib Cslib.LTS

ExternalTheorem isSimulation_comp
  := @Cslib.LTS.IsSimulation.comp
  : ∀ {State₁ : Type u_1} {State₂ : Type u_2} {State₃ : Type u_3} {Label : Type u_4}
    {lts₁ : LTS State₁ Label} {lts₂ : LTS State₂ Label} {lts₃ : LTS State₃ Label}
    (r1 : State₁ → State₂ → Prop) (r2 : State₂ → State₃ → Prop),
    IsSimulation lts₁ lts₂ r1 → IsSimulation lts₂ lts₃ r2 →
    IsSimulation lts₁ lts₃ (Relation.Comp r1 r2)

ExternalTheorem similarity_trans
  := @Cslib.LTS.Similarity.trans
  : ∀ {State : Type u_1} {Label : Type u_2} {lts₁ : LTS State Label}
    {State_1 : Type u_3} {lts₂ : LTS State_1 Label} {s₁ : State} {s2 : State_1}
    {State_2 : Type u_4} {lts₃ : LTS State_2 Label} {s₃ : State_2},
    Similarity lts₁ lts₂ s₁ s2 → Similarity lts₂ lts₃ s2 s₃ →
    Similarity lts₁ lts₃ s₁ s₃

ExternalTheorem homSimulationEquiv_eqv
  := @Cslib.LTS.HomSimulationEquiv.eqv
  : ∀ {State : Type u_1} {Label : Type u_2} {lts : LTS State Label},
    Equivalence (HomSimulationEquiv lts)
