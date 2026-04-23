import CslibHeaders.Basic
import CslibHeaders.Defs.Logics.LinearLogic.CLL.Basic
import CslibHeaders.Proofs.Logics.LinearLogic.CLL.Basic

/-! # Classical Linear Logic — sequent calculus and equivalences

  Vocabulary (see Defs/):
    Proposition Atom        — CLL propositions (atoms, connectives, exponentials)
    Proposition.dual        — propositional duality (linear negation)
    Sequent Atom            — multisets of propositions
    Proof                   — derivations in the sequent calculus
    Proposition.equiv       — proof-relevant propositional equivalence
    Proposition.Equiv       — proof-irrelevant propositional equivalence

  Read this file for WHAT is true.
  Read Defs/ for WHAT the words mean.
  Never need to open Code or Proofs.
-/

open Cslib.Logic.CLL

-- Duality preserves size
ProvenTheorem Proposition.dual_sizeOf :
  ∀ {Atom : Type u_1} (a : Proposition Atom), sizeOf a.dual = sizeOf a

-- No proposition equals its dual
ProvenTheorem Proposition.dual_neq :
  ∀ {Atom : Type u_1} (a : Proposition Atom), a ≠ a.dual

-- Duality is injective
ProvenTheorem Proposition.dual_inj :
  ∀ {Atom : Type u_1} (a b : Proposition Atom), a.dual = b.dual ↔ a = b

-- Duality is an involution
ProvenTheorem Proposition.dual_involution :
  ∀ {Atom : Type u_1} (a : Proposition Atom), a.dual.dual = a

-- Proof-irrelevant equivalence is reflexive
ProvenTheorem Proposition.Equiv.refl :
  ∀ {Atom : Type u_1} (a : Proposition Atom), a.Equiv a

-- Proof-irrelevant equivalence is symmetric
ProvenTheorem Proposition.Equiv.symm :
  ∀ {Atom : Type u_1} {a b : Proposition Atom}, a.Equiv b → b.Equiv a

-- Proof-irrelevant equivalence is transitive
ProvenTheorem Proposition.Equiv.trans :
  ∀ {Atom : Type u_1} {a b c : Proposition Atom},
    a.Equiv b → b.Equiv c → a.Equiv c
