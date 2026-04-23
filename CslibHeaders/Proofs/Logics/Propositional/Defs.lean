import Cslib.Logics.Propositional.Defs

open Cslib.Logic.PL

-- Bridge: CSLib theorems -> _proof naming convention
noncomputable def Theory.isIntuitionisticIff_proof :=
  @Theory.isIntuitionisticIff
noncomputable def Theory.isClassicalIff_proof :=
  @Theory.isClassicalIff
@[reducible] noncomputable def Theory.instIsIntuitionisticExtention_proof :=
  @Theory.instIsIntuitionisticExtention
@[reducible] noncomputable def Theory.instIsClassicalExtention_proof :=
  @Theory.instIsClassicalExtention
