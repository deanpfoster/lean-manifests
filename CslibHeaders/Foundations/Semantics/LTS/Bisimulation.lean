import CslibHeaders.Basic
import Cslib.Foundations.Semantics.LTS.Bisimulation

/-! # Bisimulation and Bisimilarity -- Header

  ## Vocabulary
  - `lts.IsBisimulation lts₂ r` -- `r` is a bisimulation between `lts` and `lts₂`
  - `lts.IsHomBisimulation r` -- `r` is a bisimulation on `lts` with itself
  - `lts.Bisimilarity lts₂ s₁ s₂` -- `s₁` and `s₂` are bisimilar
  - `lts.HomBisimilarity s₁ s₂` -- `s₁` and `s₂` are bisimilar in the same LTS
  - `s₁ ~[lts₁,lts₂] s₂` -- notation for bisimilarity
  - `s₁ ~[lts] s₂` -- notation for homogeneous bisimilarity
  - `lts.UpToHomBisimilarity lts₂ r` -- lifts `r` to homogeneous bisimilarities
  - `lts.IsBisimulationUpTo lts₂ r` -- `r` is a bisimulation up to bisimilarity
  - `lts.TraceEq lts₂ s₁ s₂` -- trace equivalence between states
  - `lts.IsSimulation lts₂ r` -- `r` is a simulation
  - `HasTau Label` -- class for labels with an internal transition `τ`
  - `lts.IsWeakBisimulation lts₂ r` -- `r` is a weak bisimulation
  - `lts.WeakBisimilarity lts₂ s₁ s₂` -- weak bisimilarity
  - `s₁ ≈[lts₁,lts₂] s₂` -- notation for weak bisimilarity
  - `lts.IsSWBisimulation lts₂ r` -- convenient characterization of weak bisimulation
  - `lts.τSTr s₁ s₂` -- saturated τ-transition relation
  - `lts.STr s₁ μ s₂` -- saturated transition relation
-/

set_option linter.style.longLine false

open Cslib Cslib.LTS

-- ════════════════════════════════════════════
-- Bisimulation basics
-- ════════════════════════════════════════════

-- Helper for following a transition by the first state in a bisimulation.
ExternalTheorem isBisimulation_follow_fst
  := @Cslib.LTS.IsBisimulation.follow_fst
  : ∀ {State : Type u_1} {Label : Type u_2} {lts₁ : LTS State Label}
    {State_1 : Type u_3} {lts₂ : LTS State_1 Label} {r : State → State_1 → Prop} {s₁ : State} {s₂ : State_1}
    {μ : Label} {s₁' : State},
    lts₁.IsBisimulation lts₂ r → r s₁ s₂ → lts₁.Tr s₁ μ s₁' → ∃ s₂', lts₂.Tr s₂ μ s₂' ∧ r s₁' s₂'

-- Helper for following a transition by the second state in a bisimulation.
ExternalTheorem isBisimulation_follow_snd
  := @Cslib.LTS.IsBisimulation.follow_snd
  : ∀ {State : Type u_1} {Label : Type u_2} {lts₁ : LTS State Label}
    {State_1 : Type u_3} {lts₂ : LTS State_1 Label} {r : State → State_1 → Prop} {s₁ : State} {s₂ : State_1}
    {μ : Label} {s₂' : State_1},
    lts₁.IsBisimulation lts₂ r → r s₁ s₂ → lts₂.Tr s₂ μ s₂' → ∃ s₁', lts₁.Tr s₁ μ s₁' ∧ r s₁' s₂'

-- ════════════════════════════════════════════
-- Bisimilarity
-- ════════════════════════════════════════════

-- Homogeneous bisimilarity is reflexive.
ExternalTheorem homBisimilarity_refl
  := @Cslib.LTS.HomBisimilarity.refl
  : ∀ {State : Type u_1} {Label : Type u_2} {lts : LTS State Label} (s : State),
    lts.HomBisimilarity s s

-- The inverse of a bisimulation is a bisimulation.
ExternalTheorem isBisimulation_inv
  := @Cslib.LTS.IsBisimulation.inv
  : ∀ {State : Type u_1} {Label : Type u_2} {lts₁ : LTS State Label}
    {State_1 : Type u_3} {lts₂ : LTS State_1 Label} {r : State → State_1 → Prop},
    lts₁.IsBisimulation lts₂ r → lts₂.IsBisimulation lts₁ (flip r)

-- Bisimilarity is symmetric.
ExternalTheorem bisimilarity_symm
  := @Cslib.LTS.Bisimilarity.symm
  : ∀ {State : Type u_1} {Label : Type u_2} {lts₁ lts₂ : LTS State Label}
    {s₁ s₂ : State}, lts₁.Bisimilarity lts₂ s₁ s₂ → lts₂.Bisimilarity lts₁ s₂ s₁

-- The composition of two bisimulations is a bisimulation.
ExternalTheorem isBisimulation_comp
  := @Cslib.LTS.IsBisimulation.comp
  : ∀ {State : Type u_1} {Label : Type u_2} {lts₁ : LTS State Label}
    {State_1 : Type u_3} {lts₂ : LTS State_1 Label} {r1 : State → State_1 → Prop} {State_2 : Type u_4}
    {lts₃ : LTS State_2 Label} {r2 : State_1 → State_2 → Prop},
    lts₁.IsBisimulation lts₂ r1 → lts₂.IsBisimulation lts₃ r2 → lts₁.IsBisimulation lts₃ (Relation.Comp r1 r2)

-- Bisimilarity is transitive.
ExternalTheorem bisimilarity_trans
  := @Cslib.LTS.Bisimilarity.trans
  : ∀ {State : Type u_1} {Label : Type u_2} {lts₁ : LTS State Label}
    {State_1 : Type u_3} {lts₂ : LTS State_1 Label} {s₁ : State} {s₂ : State_1} {State_2 : Type u_4}
    {lts₃ : LTS State_2 Label} {s₃ : State_2},
    lts₁.Bisimilarity lts₂ s₁ s₂ → lts₂.Bisimilarity lts₃ s₂ s₃ → lts₁.Bisimilarity lts₃ s₁ s₃

-- Homogeneous bisimilarity is an equivalence relation.
ExternalTheorem homBisimilarity_eqv
  := @Cslib.LTS.HomBisimilarity.eqv
  : ∀ {State : Type u_1} {Label : Type u_2} {lts : LTS State Label},
    Equivalence lts.HomBisimilarity

-- The union of two bisimulations is a bisimulation.
ExternalTheorem isBisimulation_sup
  := @Cslib.LTS.IsBisimulation.sup
  : ∀ {State : Type u_1} {Label : Type u_2} {lts₁ : LTS State Label}
    {State_1 : Type u_3} {lts₂ : LTS State_1 Label} {r s : State → State_1 → Prop},
    lts₁.IsBisimulation lts₂ r → lts₁.IsBisimulation lts₂ s → lts₁.IsBisimulation lts₂ (r ⊔ s)

-- Bisimilarity is a bisimulation.
ExternalTheorem bisimilarity_is_bisimulation
  := @Cslib.LTS.Bisimilarity.is_bisimulation
  : ∀ {State : Type u_1} {Label : Type u_2} {lts₁ : LTS State Label}
    {State_1 : Type u_3} {lts₂ : LTS State_1 Label},
    lts₁.IsBisimulation lts₂ (lts₁.Bisimilarity lts₂)

-- Bisimilarity is the largest bisimulation.
ExternalTheorem bisimilarity_largest_bisimulation
  := @Cslib.LTS.Bisimilarity.largest_bisimulation
  : ∀ {State : Type u_1} {Label : Type u_2}
    {lts₁ lts₂ : LTS State Label} {r : State → State → Prop},
    lts₁.IsBisimulation lts₂ r → Subrelation r (lts₁.Bisimilarity lts₂)

-- The union of bisimilarity with any bisimulation is bisimilarity.
ExternalTheorem bisimilarity_gfp
  := @Cslib.LTS.Bisimilarity.gfp
  : ∀ {State₁ : Type u_1} {State₂ : Type u_2} {Label : Type u_3}
    {lts₁ : LTS State₁ Label} {lts₂ : LTS State₂ Label} (r : State₁ → State₂ → Prop),
    lts₁.IsBisimulation lts₂ r → lts₁.Bisimilarity lts₂ ⊔ r = lts₁.Bisimilarity lts₂

-- The empty relation is a bisimulation.
ExternalTheorem isBisimulation_bot
  := @Cslib.LTS.IsBisimulation.bot
  : ∀ {State : Type u_1} {Label : Type u_2} {lts₁ : LTS State Label}
    {State_1 : Type u_3} {lts₂ : LTS State_1 Label},
    lts₁.IsBisimulation lts₂ Relation.emptyHRelation

-- ════════════════════════════════════════════
-- Bisimulation up-to
-- ════════════════════════════════════════════

-- Any bisimulation up to bisimilarity is a bisimulation.
ExternalTheorem isBisimulationUpTo_is_bisimulation
  := @Cslib.LTS.IsBisimulationUpTo.is_bisimulation
  : ∀ {State : Type u_1} {Label : Type u_2} {lts₁ : LTS State Label}
    {State_1 : Type u_3} {lts₂ : LTS State_1 Label} {r : State → State_1 → Prop},
    lts₁.IsBisimulationUpTo lts₂ r → lts₁.IsBisimulation lts₂ (lts₁.UpToHomBisimilarity lts₂ r)

-- ════════════════════════════════════════════
-- Relation to traces
-- ════════════════════════════════════════════

-- If two states are related by a bisimulation, they can mimic each other's multistep transitions.
ExternalTheorem isBisimulation_bisim_trace
  := @Cslib.LTS.IsBisimulation.bisim_trace
  : ∀ {State : Type u_1} {Label : Type u_2} {lts₁ : LTS State Label}
    {State_1 : Type u_3} {lts₂ : LTS State_1 Label} {r : State → State_1 → Prop} {s₁ : State} {s₂ : State_1},
    lts₁.IsBisimulation lts₂ r →
    r s₁ s₂ → ∀ (μs : List Label) (s₁' : State), lts₁.MTr s₁ μs s₁' → ∃ s₂', lts₂.MTr s₂ μs s₂' ∧ r s₁' s₂'

-- Any bisimulation implies trace equivalence.
ExternalTheorem isBisimulation_traceEq
  := @Cslib.LTS.IsBisimulation.traceEq
  : ∀ {State : Type u_1} {Label : Type u_2} {lts₁ : LTS State Label}
    {State_1 : Type u_3} {lts₂ : LTS State_1 Label} {r : State → State_1 → Prop} {s₁ : State} {s₂ : State_1},
    lts₁.IsBisimulation lts₂ r → r s₁ s₂ → lts₁.TraceEq lts₂ s₁ s₂

-- Bisimilarity is included in trace equivalence.
ExternalTheorem bisimilarity_le_traceEq
  := @Cslib.LTS.Bisimilarity.le_traceEq
  : ∀ {State : Type u_1} {Label : Type u_2} {lts₁ : LTS State Label}
    {State_1 : Type u_3} {lts₂ : LTS State_1 Label},
    lts₁.Bisimilarity lts₂ ≤ lts₁.TraceEq lts₂

-- In general, trace equivalence is not a bisimulation.
ExternalTheorem traceEq_not_bisim
  := @Cslib.LTS.IsBisimulation.traceEq_not_bisim
  : ∃ (State : Type) (Label : Type) (lts : LTS State Label),
    ¬IsHomBisimulation lts (HomTraceEq lts)

-- In general, bisimilarity and trace equivalence are distinct.
ExternalTheorem bisimilarity_neq_traceEq
  := @Cslib.LTS.Bisimilarity.bisimilarity_neq_traceEq
  : ∃ (State : Type) (Label : Type) (lts : LTS State Label),
    HomBisimilarity lts ≠ HomTraceEq lts

-- In any deterministic LTS, trace equivalence is a bisimulation.
ExternalTheorem deterministic_traceEq_isBisimulation
  := @Cslib.LTS.IsBisimulation.deterministic_traceEq_isBisimulation
  : ∀ {State₁ : Type u_1} {Label : Type u_2}
    {State₂ : Type u_3} {lts₁ : LTS State₁ Label} {lts₂ : LTS State₂ Label} [lts₁.Deterministic]
    [lts₂.Deterministic], lts₁.IsBisimulation lts₂ (lts₁.TraceEq lts₂)

-- In deterministic LTSs, trace equivalence implies bisimilarity.
ExternalTheorem deterministic_traceEq_bisim
  := @Cslib.LTS.Bisimilarity.deterministic_traceEq_bisim
  : ∀ {State₁ : Type u_1} {Label : Type u_2} {State₂ : Type u_3}
    {s₁ : State₁} {s₂ : State₂} {lts₁ : LTS State₁ Label} {lts₂ : LTS State₂ Label} [lts₁.Deterministic]
    [lts₂.Deterministic], lts₁.TraceEq lts₂ s₁ s₂ → lts₁.Bisimilarity lts₂ s₁ s₂

-- In deterministic LTSs, bisimilarity and trace equivalence coincide.
ExternalTheorem deterministic_bisim_eq_traceEq
  := @Cslib.LTS.Bisimilarity.deterministic_bisim_eq_traceEq
  : ∀ {State₁ : Type u_1} {Label : Type u_2} {State₂ : Type u_3}
    {lts₁ : LTS State₁ Label} {lts₂ : LTS State₂ Label} [lts₁.Deterministic] [lts₂.Deterministic],
    lts₁.Bisimilarity lts₂ = lts₁.TraceEq lts₂

-- ════════════════════════════════════════════
-- Relation to simulation
-- ════════════════════════════════════════════

-- Any bisimulation is also a simulation.
ExternalTheorem isBisimulation_isSimulation
  := @Cslib.LTS.IsBisimulation.isSimulation
  : ∀ {State : Type u_1} {Label : Type u_2} {lts₁ : LTS State Label}
    {State_1 : Type u_3} {lts₂ : LTS State_1 Label} {r : State → State_1 → Prop},
    lts₁.IsBisimulation lts₂ r → lts₁.IsSimulation lts₂ r

-- A relation is a bisimulation iff both it and its inverse are simulations.
ExternalTheorem isBisimulation_isSimulation_iff
  := @Cslib.LTS.IsBisimulation.isSimulation_iff
  : ∀ {State : Type u_1} {Label : Type u_2} {lts₁ : LTS State Label}
    {State_1 : Type u_3} {lts₂ : LTS State_1 Label} {r : State → State_1 → Prop},
    lts₁.IsBisimulation lts₂ r ↔ lts₁.IsSimulation lts₂ r ∧ lts₂.IsSimulation lts₁ (flip r)

-- Homogeneous bisimilarity can be characterized through symmetric simulations.
ExternalTheorem homBisimilarity_symm_simulation
  := @Cslib.LTS.HomBisimilarity.symm_simulation
  : ∀ {State : Type u_1} {Label : Type u_2} {lts : LTS State Label},
    lts.HomBisimilarity = fun s₁ s₂ => ∃ r, r s₁ s₂ ∧ Std.Symm r ∧ lts.IsHomSimulation r

-- ════════════════════════════════════════════
-- Weak bisimulation
-- ════════════════════════════════════════════

-- Utility: following internal transitions using an SWBisimulation (first component).
ExternalTheorem isSWBisimulation_follow_internal_fst
  := @Cslib.LTS.IsSWBisimulation.follow_internal_fst
  : ∀ {Label : Type u_1} {State₁ : Type u_2} {State₂ : Type u_3}
    {r : State₁ → State₂ → Prop} {s₁ : State₁} {s₂ : State₂} {s₁' : State₁} [inst : HasTau Label]
    {lts₁ : LTS State₁ Label} {lts₂ : LTS State₂ Label},
    lts₁.IsSWBisimulation lts₂ r → r s₁ s₂ → lts₁.τSTr s₁ s₁' → ∃ s₂', lts₂.τSTr s₂ s₂' ∧ r s₁' s₂'

-- Utility: following internal transitions using an SWBisimulation (second component).
ExternalTheorem isSWBisimulation_follow_internal_snd
  := @Cslib.LTS.IsSWBisimulation.follow_internal_snd
  : ∀ {Label : Type u_1} {State₁ : Type u_2} {State₂ : Type u_3}
    {r : State₁ → State₂ → Prop} {s₁ : State₁} {s₂ s₂' : State₂} [inst : HasTau Label]
    {lts₁ : LTS State₁ Label} {lts₂ : LTS State₂ Label},
    lts₁.IsSWBisimulation lts₂ r → r s₁ s₂ → lts₂.τSTr s₂ s₂' → ∃ s₁', lts₁.τSTr s₁ s₁' ∧ r s₁' s₂'

-- A relation is a WeakBisimulation iff it is an SWBisimulation.
ExternalTheorem isWeakBisimulation_iff_isSWBisimulation
  := @Cslib.LTS.isWeakBisimulation_iff_isSWBisimulation
  : ∀ {Label : Type u_1} {State₁ : Type u_2} {State₂ : Type u_3}
    {r : State₁ → State₂ → Prop} [inst : HasTau Label] {lts₁ : LTS State₁ Label}
    {lts₂ : LTS State₂ Label}, lts₁.IsWeakBisimulation lts₂ r ↔ lts₁.IsSWBisimulation lts₂ r

ExternalTheorem isWeakBisimulation_isSwBisimulation
  := @Cslib.LTS.IsWeakBisimulation.isSwBisimulation
  : ∀ {Label : Type u_1} {State₁ : Type u_2} {State₂ : Type u_3}
    [inst : HasTau Label] {lts₁ : LTS State₁ Label} {lts₂ : LTS State₂ Label}
    {r : State₁ → State₂ → Prop}, lts₁.IsWeakBisimulation lts₂ r → lts₁.IsSWBisimulation lts₂ r

ExternalTheorem isSWBisimulation_isWeakBisimulation
  := @Cslib.LTS.IsSWBisimulation.isWeakBisimulation
  : ∀ {Label : Type u_1} {State₁ : Type u_2} {State₂ : Type u_3}
    [inst : HasTau Label] {lts₁ : LTS State₁ Label} {lts₂ : LTS State₂ Label}
    {r : State₁ → State₂ → Prop}, lts₁.IsSWBisimulation lts₂ r → lts₁.IsWeakBisimulation lts₂ r

-- Weak bisimilarity can be characterized through sw-bisimulations.
ExternalTheorem weakBisim_eq_swBisim
  := @Cslib.LTS.WeakBisimilarity.weakBisim_eq_swBisim
  : ∀ {Label : Type u_1} {State₁ : Type u_2} {State₂ : Type u_3}
    [inst : HasTau Label] (lts₁ : LTS State₁ Label) (lts₂ : LTS State₂ Label),
    lts₁.WeakBisimilarity lts₂ = fun s₁ s₂ => ∃ r, r s₁ s₂ ∧ lts₁.IsSWBisimulation lts₂ r

-- Homogeneous weak bisimilarity is reflexive.
ExternalTheorem homWeakBisimilarity_refl
  := @Cslib.LTS.HomWeakBisimilarity.refl
  : ∀ {Label : Type u_1} {State : Type u_2} [inst : HasTau Label]
    {lts : LTS State Label} (s : State), lts.HomWeakBisimilarity s s

-- The inverse of a weak bisimulation is a weak bisimulation.
ExternalTheorem isWeakBisimulation_inv
  := @Cslib.LTS.IsWeakBisimulation.inv
  : ∀ {Label : Type u_1} {State₁ : Type u_2} {State₂ : Type u_3}
    [inst : HasTau Label] {lts₁ : LTS State₁ Label} {lts₂ : LTS State₂ Label}
    (r : State₁ → State₂ → Prop), lts₁.IsWeakBisimulation lts₂ r → lts₂.IsWeakBisimulation lts₁ (flip r)

-- Weak bisimilarity is symmetric.
ExternalTheorem weakBisimilarity_symm
  := @Cslib.LTS.WeakBisimilarity.symm
  : ∀ {Label : Type u_1} {State₁ : Type u_2} {State₂ : Type u_3} {s₁ : State₁}
    {s₂ : State₂} [inst : HasTau Label] {lts₁ : LTS State₁ Label} {lts₂ : LTS State₂ Label},
    lts₁.WeakBisimilarity lts₂ s₁ s₂ → lts₂.WeakBisimilarity lts₁ s₂ s₁

-- The composition of two weak bisimulations is a weak bisimulation.
ExternalTheorem isWeakBisimulation_comp
  := @Cslib.LTS.IsWeakBisimulation.comp
  : ∀ {Label : Type u_1} {State₁ : Type u_2} {State₂ : Type u_3} {State₃ : Type u_4}
    {r1 : State₁ → State₂ → Prop} {r2 : State₂ → State₃ → Prop} [inst : HasTau Label]
    {lts₁ : LTS State₁ Label} {lts₂ : LTS State₂ Label} {lts₃ : LTS State₃ Label},
    lts₁.IsWeakBisimulation lts₂ r1 → lts₂.IsWeakBisimulation lts₃ r2 →
    lts₁.IsWeakBisimulation lts₃ (Relation.Comp r1 r2)

-- The composition of two sw-bisimulations is an sw-bisimulation.
ExternalTheorem isSWBisimulation_comp
  := @Cslib.LTS.IsSWBisimulation.comp
  : ∀ {Label : Type u_1} {State₁ : Type u_2} {State₂ : Type u_3} {State₃ : Type u_4}
    {r1 : State₁ → State₂ → Prop} {r2 : State₂ → State₃ → Prop} [inst : HasTau Label]
    {lts₁ : LTS State₁ Label} {lts₂ : LTS State₂ Label} {lts₃ : LTS State₃ Label},
    lts₁.IsSWBisimulation lts₂ r1 → lts₂.IsSWBisimulation lts₃ r2 →
    lts₁.IsSWBisimulation lts₃ (Relation.Comp r1 r2)

-- Weak bisimilarity is transitive.
ExternalTheorem weakBisimilarity_trans
  := @Cslib.LTS.WeakBisimilarity.trans
  : ∀ {Label : Type u_1} {State₁ : Type u_2} {State₂ : Type u_3} {State₃ : Type u_4}
    {s₁ : State₁} {s₂ : State₂} {s₃ : State₃} [inst : HasTau Label] {lts₁ : LTS State₁ Label}
    {lts₂ : LTS State₂ Label} {lts₃ : LTS State₃ Label},
    lts₁.WeakBisimilarity lts₂ s₁ s₂ → lts₂.WeakBisimilarity lts₃ s₂ s₃ →
    lts₁.WeakBisimilarity lts₃ s₁ s₃

-- Homogeneous weak bisimilarity is an equivalence relation.
ExternalTheorem homWeakBisimilarity_eqv
  := @Cslib.LTS.HomWeakBisimilarity.eqv
  : ∀ {Label : Type u_1} {State : Type u_2} [inst : HasTau Label]
    {lts : LTS State Label}, Equivalence lts.HomWeakBisimilarity
