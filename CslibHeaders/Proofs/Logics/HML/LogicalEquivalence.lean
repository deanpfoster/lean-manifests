import Cslib.Logics.HML.LogicalEquivalence

open Cslib.Logic.HML

-- Bridge: CSLib theorems -> _proof naming convention
noncomputable def Proposition.equiv_def_proof
    {State : Type u} {Label : Type v} :=
  @Proposition.equiv_def State Label
noncomputable def Satisfies.bundled_char_proof := @Satisfies.bundled_char
