import Cslib.Logics.LinearLogic.CLL.MLL

open Cslib.Logic.CLL

-- Bridge: CSLib theorems -> _proof naming convention
noncomputable def Proposition.isMLL_dual_proof := @Proposition.isMLL_dual
noncomputable def Proposition.Context.isMLL_fill_proof := @Proposition.Context.isMLL_fill
noncomputable def Proof.isMLL_sequent_proof := @Proof.isMLL_sequent
