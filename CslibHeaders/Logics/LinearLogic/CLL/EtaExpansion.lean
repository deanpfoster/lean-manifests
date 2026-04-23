import CslibHeaders.Basic
import CslibHeaders.Defs.Logics.LinearLogic.CLL.EtaExpansion
import CslibHeaders.Proofs.Logics.LinearLogic.CLL.EtaExpansion

/-! # Eta expansion for CLL

  Vocabulary (see Defs/):
    Proposition.expand      — eta-expansion of a proposition to a proof with atomic axioms only
    Proof.onlyAtomicAxioms  — checks that all axiom instances are atomic

  Read this file for WHAT is true.
  Read Defs/ for WHAT the words mean.
  Never need to open Code or Proofs.
-/

open Cslib.Logic.CLL

-- Eta-expansion produces proofs with only atomic axioms
ProvenTheorem Proof.expand_onlyAtomicAxioms :
  ∀ {Atom : Type u_1} (a : Proposition Atom),
    Proof.onlyAtomicAxioms a.expand = true
