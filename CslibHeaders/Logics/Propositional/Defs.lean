import CslibHeaders.Basic
import CslibHeaders.Defs.Logics.Propositional.Defs
import CslibHeaders.Proofs.Logics.Propositional.Defs

/-! # Propositional Logic — basic definitions

  Vocabulary (see Defs/):
    Proposition Atom        — propositions (atoms, and, or, impl)
    Proposition.map         — functorial action on atoms
    Theory Atom             — sets of propositions
    Theory.MPL              — minimal propositional logic (empty theory)
    Theory.IPL              — intuitionistic propositional logic
    Theory.CPL              — classical propositional logic
    Theory.IsIntuitionistic — theory validates ex falso quodlibet
    Theory.IsClassical      — theory validates double negation elimination

  Read this file for WHAT is true.
  Read Defs/ for WHAT the words mean.
  Never need to open Code or Proofs.
-/

open Cslib.Logic.PL

-- A theory is intuitionistic iff it contains IPL
ProvenTheorem Theory.isIntuitionisticIff :
  ∀ {Atom : Type u_1} [inst : Bot Atom] (T : Theory Atom),
    T.IsIntuitionistic ↔ Theory.IPL ⊆ T

-- A theory is classical iff it contains CPL
ProvenTheorem Theory.isClassicalIff :
  ∀ {Atom : Type u_1} [inst : Bot Atom] (T : Theory Atom),
    T.IsClassical ↔ Theory.CPL ⊆ T

-- Intuitionistic property is preserved by extension
ProvenTheorem Theory.instIsIntuitionisticExtention :
  ∀ {Atom : Type u_1} [inst : Bot Atom]
    {T T' : Theory Atom} [T.IsIntuitionistic],
    T ⊆ T' → T'.IsIntuitionistic

-- Classical property is preserved by extension
ProvenTheorem Theory.instIsClassicalExtention :
  ∀ {Atom : Type u_1} [inst : Bot Atom]
    {T T' : Theory Atom} [T.IsClassical],
    T ⊆ T' → T'.IsClassical
