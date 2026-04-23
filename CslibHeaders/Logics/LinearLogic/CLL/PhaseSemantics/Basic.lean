import CslibHeaders.Basic
import CslibHeaders.Defs.Logics.LinearLogic.CLL.PhaseSemantics.Basic
import CslibHeaders.Proofs.Logics.LinearLogic.CLL.PhaseSemantics.Basic

/-! # Phase Semantics for Classical Linear Logic

  Key types (imported directly):
    PhaseSpace M            — commutative monoid with distinguished subset bot
    orthogonal X            — orthogonal of a set (elements mapping X into bot)
    isFact X                — X equals its biorthogonal closure
    Fact P                  — type of facts in a phase space
    biorthogonalClosure     — closure operator on sets
    interpProp v A          — interpretation of CLL propositions as facts

  Read this file for WHAT is true.
  Never need to open Code or Proofs.
-/

open Cslib.Logic.CLL.PhaseSpace

-- Orthogonal is antitone: X <= Y implies Y-orth <= X-orth
ProvenTheorem orth_antitone :
  ∀ {P : Type u_1} [inst : Cslib.Logic.CLL.PhaseSpace P] {X Y : Set P},
    X ⊆ Y → orthogonal Y ⊆ orthogonal X

-- Biorthogonal is extensive: X <= X-orth-orth
ProvenTheorem orth_extensive :
  ∀ {P : Type u_1} [inst : Cslib.Logic.CLL.PhaseSpace P] (X : Set P),
    X ⊆ orthogonal (orthogonal X)

-- Triple orthogonal equals single orthogonal
ProvenTheorem triple_orth :
  ∀ {P : Type u_1} [inst : Cslib.Logic.CLL.PhaseSpace P] (X : Set P),
    orthogonal (orthogonal (orthogonal X)) = orthogonal X

-- Orthogonal of union = intersection of orthogonals
ProvenTheorem orth_iUnion :
  ∀ {P : Type u_1} [inst : Cslib.Logic.CLL.PhaseSpace P] {ι : Sort u_2}
    (G : ι → Set P),
    orthogonal (⋃ i, G i) = ⋂ i, orthogonal (G i)

-- Arbitrary intersections of facts are facts
ProvenTheorem sInf_isFact :
  ∀ {P : Type u_1} [inst : Cslib.Logic.CLL.PhaseSpace P]
    {S : Set (Fact P)},
    isFact (sInf ((fun (F : Fact P) => (F : Set P)) '' S))

-- Binary intersections of facts are facts
ProvenTheorem inter_isFact_of_isFact :
  ∀ {P : Type u_1} [inst : Cslib.Logic.CLL.PhaseSpace P]
    {A B : Set P},
    isFact A → isFact B → isFact (A ∩ B)

-- Biorthogonal closure gives the smallest fact containing a set
ProvenTheorem biorth_least_fact :
  ∀ {P : Type u_1} [inst : Cslib.Logic.CLL.PhaseSpace P] (G : Set P)
    {F : Set P},
    isFact F → G ⊆ F → orthogonal (orthogonal G) ⊆ F
