import CslibHeaders.Basic
import CslibHeaders.Defs.Logics.HML.Basic
import CslibHeaders.Proofs.Logics.HML.Basic

/-! # Hennessy-Milner Logic (HML) — characterization theorems

  Vocabulary (see Defs/):
    Proposition Label       — HML propositions (true, false, and, or, diamond, box)
    Satisfies lts s a       — state s satisfies proposition a in LTS lts
    Proposition.denotation  — set of states satisfying a proposition
    theory lts s            — set of all propositions satisfied by state s
    TheoryEq lts s1 s2      — two states have the same theory

  Read this file for WHAT is true.
  Read Defs/ for WHAT the words mean.
  Never need to open Code or Proofs.
-/

open Cslib.Logic.HML

-- Denotational semantics is correct: satisfaction iff membership in denotation
ProvenTheorem satisfies_mem_denotation :
  ∀ {State : Type u_1} {Label : Type u_2} {s : State}
    {a : Proposition Label} {lts : Cslib.LTS State Label},
    Satisfies lts s a ↔ s ∈ a.denotation lts

-- A state satisfies a proposition iff it does not satisfy the negation
ProvenTheorem neg_satisfies :
  ∀ {State : Type u_1} {Label : Type u_2} {s : State}
    {a : Proposition Label} {lts : Cslib.LTS State Label},
    ¬Satisfies lts s a.neg ↔ Satisfies lts s a

-- A state is in the denotation iff it is not in the denotation of the negation
ProvenTheorem neg_denotation :
  ∀ {State : Type u_1} {Label : Type u_2} {s : State}
    {lts : Cslib.LTS State Label} (a : Proposition Label),
    s ∉ a.neg.denotation lts ↔ s ∈ a.denotation lts

-- A state satisfies a finite conjunction iff it satisfies all conjuncts
ProvenTheorem satisfies_finiteAnd :
  ∀ {State : Type u_1} {Label : Type u_2} {lts : Cslib.LTS State Label}
    {s : State} {as : List (Proposition Label)},
    Satisfies lts s (Proposition.finiteAnd as) ↔ ∀ a ∈ as, Satisfies lts s a

-- A state satisfies a finite disjunction iff it satisfies some disjunct
ProvenTheorem satisfies_finiteOr :
  ∀ {State : Type u_1} {Label : Type u_2} {lts : Cslib.LTS State Label}
    {s : State} {as : List (Proposition Label)},
    Satisfies lts s (Proposition.finiteOr as) ↔ ∃ a ∈ as, Satisfies lts s a

-- Satisfaction implies membership in the theory
ProvenTheorem satisfies_theory :
  ∀ {State : Type u_1} {Label : Type u_2} {lts : Cslib.LTS State Label}
    {s : State} {a : Proposition Label},
    Satisfies lts s a → a ∈ theory lts s

-- Theory equivalence iff denotational equivalence
ProvenTheorem theoryEq_denotation_eq :
  ∀ {State : Type u_1} {Label : Type u_2} {s1 s2 : State}
    {lts : Cslib.LTS State Label},
    TheoryEq lts s1 s2 ↔
    ∀ (a : Proposition Label), s1 ∈ a.denotation lts ↔ s2 ∈ a.denotation lts

-- Non-equivalent states have a distinguishing proposition
ProvenTheorem not_theoryEq_satisfies :
  ∀ {State : Type u_1} {Label : Type u_2} {lts : Cslib.LTS State Label}
    {s1 s2 : State},
    ¬TheoryEq lts s1 s2 →
    ∃ a, Satisfies lts s1 a ∧ ¬Satisfies lts s2 a

-- Theory-equivalent states satisfy the same propositions
ProvenTheorem theoryEq_satisfies :
  ∀ {State : Type u_1} {Label : Type u_2} {s1 s2 : State}
    {a : Proposition Label} {lts : Cslib.LTS State Label},
    TheoryEq lts s1 s2 → Satisfies lts s1 a → Satisfies lts s2 a

-- Theory equivalence is a bisimulation (for image-finite LTSs)
ProvenTheorem theoryEq_isBisimulation :
  ∀ {State : Type u_1} {Label : Type u_2} (lts : Cslib.LTS State Label)
    [image_finite : ∀ (s : State) (μ : Label), Finite ↑(lts.image s μ)],
    lts.IsHomBisimulation (TheoryEq lts)

-- Bisimulation-related states satisfy the same propositions
ProvenTheorem bisimulation_satisfies :
  ∀ {State : Type u_1} {Label : Type u_2} {r : State → State → Prop}
    {s1 s2 : State} {lts : Cslib.LTS State Label}
    (hrb : lts.IsHomBisimulation r),
    r s1 s2 → ∀ (a : Proposition Label),
    Satisfies lts s1 a → Satisfies lts s2 a

-- Bisimulation-related states are theory-equivalent
ProvenTheorem bisimulation_TheoryEq :
  ∀ {State : Type u_1} {Label : Type u_2} {r : State → State → Prop}
    {s1 s2 : State} {lts : Cslib.LTS State Label}
    (hrb : lts.IsHomBisimulation r),
    r s1 s2 → TheoryEq lts s1 s2

-- Modal characterization: theory equivalence = bisimilarity (for image-finite LTSs)
-- ([Hennessy1985], main theorem)
ProvenTheorem theoryEq_eq_bisimilarity :
  ∀ {State : Type u_1} {Label : Type u_2} (lts : Cslib.LTS State Label)
    [image_finite : ∀ (s : State) (μ : Label), Finite ↑(lts.image s μ)],
    TheoryEq lts = lts.HomBisimilarity
