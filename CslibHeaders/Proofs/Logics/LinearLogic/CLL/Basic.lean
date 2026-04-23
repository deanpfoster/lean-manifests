import Cslib.Logics.LinearLogic.CLL.Basic

open Cslib.Logic.CLL

-- Bridge: CSLib theorems -> _proof naming convention
noncomputable def Proposition.context_fill_def_proof := @Proposition.context_fill_def
noncomputable def Proposition.dual_sizeOf_proof := @Proposition.dual_sizeOf
noncomputable def Proposition.dual_neq_proof := @Proposition.dual_neq
noncomputable def Proposition.dual_inj_proof := @Proposition.dual_inj
noncomputable def Proposition.dual_involution_proof := @Proposition.dual_involution
noncomputable def Proposition.Equiv.refl_proof := @Proposition.Equiv.refl
noncomputable def Proposition.Equiv.symm_proof := @Proposition.Equiv.symm
noncomputable def Proposition.Equiv.trans_proof := @Proposition.Equiv.trans
