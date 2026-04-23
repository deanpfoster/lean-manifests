import CslibHeaders.Basic
import CslibHeaders.Defs.Logics.HML.LogicalEquivalence
import CslibHeaders.Proofs.Logics.HML.LogicalEquivalence

/-! # Logical Equivalence in HML

  Vocabulary (see Defs/):
    Proposition.Equiv       — logical equivalence for HML propositions
    Proposition.Context     — propositional contexts (single-hole)
    Satisfies.Judgement     — bundled judgement for satisfaction
    Satisfies.Bundled       — bundled satisfaction relation

  Read this file for WHAT is true.
  Read Defs/ for WHAT the words mean.
  Never need to open Code or Proofs.
-/

open Cslib.Logic.HML

-- Characterization of propositional equivalence via denotations
ProvenTheorem Proposition.equiv_def :
  ∀ {State : Type u_1} {Label : Type u_2}
    (a b : Proposition Label),
    Proposition.Equiv (State := State) a b ↔
    ∀ (lts : Cslib.LTS State Label), a.denotation lts = b.denotation lts

-- Bundled satisfaction coincides with standard satisfaction
ProvenTheorem Satisfies.bundled_char :
  ∀ {State : Type u_1} {Label : Type u_2}
    {j : Satisfies.Judgement State Label},
    Satisfies.Bundled j ↔ Satisfies j.lts j.state j.φ
