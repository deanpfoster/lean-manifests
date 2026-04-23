import CslibHeaders.Basic
import CslibHeaders.Defs.Logics.LinearLogic.CLL.MLL
import CslibHeaders.Proofs.Logics.LinearLogic.CLL.MLL

/-! # Multiplicative Linear Logic (MLL) as a fragment of CLL

  Vocabulary (see Defs/):
    Proposition.IsMLL       — a proposition is in the multiplicative fragment
    Sequent.IsMLL           — a sequent is multiplicative
    Proof.IsMLL             — a proof is multiplicative

  Read this file for WHAT is true.
  Read Defs/ for WHAT the words mean.
  Never need to open Code or Proofs.
-/

open Cslib.Logic.CLL

-- Duality in MLL stays in MLL
ProvenTheorem Proposition.isMLL_dual :
  ∀ {Atom : Type u_1} {a : Proposition Atom},
    a.IsMLL → a.dual.IsMLL

-- Filling a multiplicative context with a multiplicative proposition stays in MLL
ProvenTheorem Proposition.Context.isMLL_fill :
  ∀ {Atom : Type u_1} {c : Proposition.Context Atom}
    {a : Proposition Atom},
    c.IsMLL → ((c.fill a).IsMLL ↔ a.IsMLL)

-- An MLL proof can only prove MLL sequents
ProvenTheorem Proof.isMLL_sequent :
  ∀ {Atom : Type u_1} {Γ : Sequent Atom}
    (p : Cslib.Logic.InferenceSystem.derivation Γ),
    Proof.IsMLL p → Γ.IsMLL
