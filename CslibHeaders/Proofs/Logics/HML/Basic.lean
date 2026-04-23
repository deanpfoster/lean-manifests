import Cslib.Logics.HML.Basic

open Cslib.Logic.HML

-- Bridge: CSLib theorems -> _proof naming convention
noncomputable def satisfies_mem_denotation_proof := @satisfies_mem_denotation
noncomputable def neg_satisfies_proof := @neg_satisfies
noncomputable def neg_denotation_proof := @neg_denotation
noncomputable def satisfies_finiteAnd_proof := @satisfies_finiteAnd
noncomputable def satisfies_finiteOr_proof := @satisfies_finiteOr
noncomputable def satisfies_theory_proof := @satisfies_theory
noncomputable def theoryEq_denotation_eq_proof := @theoryEq_denotation_eq
noncomputable def not_theoryEq_satisfies_proof := @not_theoryEq_satisfies
noncomputable def theoryEq_satisfies_proof := @theoryEq_satisfies
noncomputable def theoryEq_isBisimulation_proof := @theoryEq_isBisimulation
noncomputable def bisimulation_satisfies_proof
    {State : Type u_1} {Label : Type u_2} {r : State → State → Prop}
    {s1 s2 : State} {lts : Cslib.LTS State Label}
    (hrb : lts.IsHomBisimulation r) :=
  @bisimulation_satisfies State Label r s1 s2 lts hrb
noncomputable def bisimulation_TheoryEq_proof
    {State : Type u_1} {Label : Type u_2} {r : State → State → Prop}
    {s1 s2 : State} {lts : Cslib.LTS State Label}
    (hrb : lts.IsHomBisimulation r) :=
  @bisimulation_TheoryEq State Label r s1 s2 lts hrb
noncomputable def theoryEq_eq_bisimilarity_proof := @theoryEq_eq_bisimilarity
