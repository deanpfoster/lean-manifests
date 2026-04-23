import CslibHeaders.Basic
import Cslib.Foundations.Semantics.LTS.Basic

/-! # Labelled Transition System (LTS) -- Header

  ## Vocabulary
  - `LTS State Label` -- structure with `Tr : State -> Label -> State -> Prop`
  - `lts.MTr s1 μs s2` -- multistep transition: `s1` reaches `s2` via label sequence `μs`
  - `lts.CanReach s1 s2` -- `s1` can reach `s2` via some multistep transition
  - `lts.image s μ` -- set of `μ`-derivatives of state `s`
  - `lts.imageMultistep s μs` -- set of `μs`-derivatives of state `s`
  - `lts.setImage S μ` -- `μ`-image of a set of states `S`
  - `lts.setImageMultistep S μs` -- `μs`-image of a set of states `S`
  - `lts.Deterministic` -- class: no two distinct derivatives from same state-label
  - `lts.ImageFinite` -- all images of states are finite
  - `lts.FinitelyBranching` -- image-finite with finite outgoing labels
  - `lts.Acyclic` -- no infinite multistep transitions
  - `lts.FiniteLTS` -- finite-state and acyclic
-/

open Cslib Cslib.LTS

-- ════════════════════════════════════════════
-- Multistep transitions
-- ════════════════════════════════════════════

-- Any transition is also a multistep transition.
ExternalTheorem mtr_single
  := @Cslib.LTS.MTr.single
  : ∀ {State : Type u_1} {Label : Type u_2} (lts : LTS State Label) {s1 : State} {μ : Label}
    {s2 : State}, lts.Tr s1 μ s2 → lts.MTr s1 [μ] s2

-- Any multistep transition can be extended by adding a transition.
ExternalTheorem mtr_stepR
  := @Cslib.LTS.MTr.stepR
  : ∀ {State : Type u_1} {Label : Type u_2} (lts : LTS State Label) {s1 : State}
    {μs : List Label} {s2 : State} {μ : Label} {s3 : State},
    lts.MTr s1 μs s2 → lts.Tr s2 μ s3 → lts.MTr s1 (μs ++ [μ]) s3

-- Multistep transitions can be composed.
ExternalTheorem mtr_comp
  := @Cslib.LTS.MTr.comp
  : ∀ {State : Type u_1} {Label : Type u_2} (lts : LTS State Label) {s1 : State}
    {μs1 : List Label} {s2 : State} {μs2 : List Label} {s3 : State},
    lts.MTr s1 μs1 s2 → lts.MTr s2 μs2 s3 → lts.MTr s1 (μs1 ++ μs2) s3

-- Any 1-sized multistep transition implies a transition with the same states and label.
ExternalTheorem mtr_single_invert
  := @Cslib.LTS.MTr.single_invert
  : ∀ {State : Type u_1} {Label : Type u_2} (lts : LTS State Label) (s1 : State)
    (μ : Label) (s2 : State), lts.MTr s1 [μ] s2 → lts.Tr s1 μ s2

-- In any zero-step multistep transition, the origin and derivative are the same.
ExternalTheorem mtr_nil_eq
  := @Cslib.LTS.MTr.nil_eq
  : ∀ {State : Type u_1} {Label : Type u_2} (lts : LTS State Label) {s1 s2 : State},
    lts.MTr s1 [] s2 → s1 = s2

-- ════════════════════════════════════════════
-- Reachability
-- ════════════════════════════════════════════

-- Any state can reach itself.
ExternalTheorem canReach_refl
  := @Cslib.LTS.CanReach.refl
  : ∀ {State : Type u_1} {Label : Type u_2} (lts : LTS State Label) (s : State),
    lts.CanReach s s

-- ════════════════════════════════════════════
-- Image operations
-- ════════════════════════════════════════════

-- Characterisation of `setImage` wrt `Tr`.
ExternalTheorem mem_setImage
  := @Cslib.LTS.mem_setImage
  : ∀ {State : Type u_1} {Label : Type u_2} {S : Set State} {μ : Label} {s' : State}
    {lts : LTS State Label}, s' ∈ lts.setImage S μ ↔ ∃ s ∈ S, lts.Tr s μ s'

ExternalTheorem tr_setImage
  := @Cslib.LTS.tr_setImage
  : ∀ {State : Type u_1} {Label : Type u_2} {S : Set State} {s : State} {μ : Label} {s' : State}
    {lts : LTS State Label}, s ∈ S → lts.Tr s μ s' → s' ∈ lts.setImage S μ

-- Characterisation of `setImageMultistep` with `MTr`.
ExternalTheorem mem_setImageMultistep
  := @Cslib.LTS.mem_setImageMultistep
  : ∀ {State : Type u_1} {Label : Type u_2} {S : Set State} {μs : List Label}
    {s' : State} {lts : LTS State Label},
    s' ∈ lts.setImageMultistep S μs ↔ ∃ s ∈ S, lts.MTr s μs s'

ExternalTheorem mTr_setImage
  := @Cslib.LTS.mTr_setImage
  : ∀ {State : Type u_1} {Label : Type u_2} {S : Set State} {s : State} {μs : List Label}
    {s' : State} {lts : LTS State Label},
    s ∈ S → lts.MTr s μs s' → s' ∈ lts.setImageMultistep S μs

-- The image of the empty set is always the empty set.
ExternalTheorem setImage_empty
  := @Cslib.LTS.setImage_empty
  : ∀ {State : Type u_1} {Label : Type u_2} {μ : Label} (lts : LTS State Label),
    lts.setImage ∅ μ = ∅

ExternalTheorem setImageMultistep_setImage_head
  := @Cslib.LTS.setImageMultistep_setImage_head
  : ∀ {State : Type u_1} {Label : Type u_2} {S : Set State} {μ : Label}
    {μs : List Label} (lts : LTS State Label),
    lts.setImageMultistep S (μ :: μs) = lts.setImageMultistep (lts.setImage S μ) μs

-- Characterisation of `setImageMultistep` as `List.foldl` on `setImage`.
ExternalTheorem setImageMultistep_foldl_setImage
  := @Cslib.LTS.setImageMultistep_foldl_setImage
  : ∀ {State : Type u_1} {Label : Type u_2} (lts : LTS State Label),
    lts.setImageMultistep = List.foldl lts.setImage

-- Characterisation of membership in `List.foldl lts.setImage` with `MTr`.
ExternalTheorem mem_foldl_setImage
  := @Cslib.LTS.mem_foldl_setImage
  : ∀ {State : Type u_1} {Label : Type u_2} {S : Set State} {μs : List Label} {s' : State}
    (lts : LTS State Label),
    s' ∈ List.foldl lts.setImage S μs ↔ ∃ s ∈ S, lts.MTr s μs s'

-- ════════════════════════════════════════════
-- Deterministic LTS properties
-- ════════════════════════════════════════════

-- In a deterministic LTS, if a state has a `μ`-derivative, it can have no other `μ`-derivative.
ExternalTheorem deterministic_not_lto
  := @Cslib.LTS.deterministic_not_lto
  : ∀ {State : Type u_1} {Label : Type u_2} (lts : LTS State Label)
    [h : lts.Deterministic] (s : State) (μ : Label) (s' s'' : State),
    s' ≠ s'' → lts.Tr s μ s' → ¬lts.Tr s μ s''

ExternalTheorem deterministic_tr_image_singleton
  := @Cslib.LTS.deterministic_tr_image_singleton
  : ∀ {State : Type u_1} {Label : Type u_2} (lts : LTS State Label)
    {s : State} {μ : Label} {s' : State} [lts.Deterministic],
    lts.image s μ = {s'} ↔ lts.Tr s μ s'

-- In a deterministic LTS, any image is either a singleton or the empty set.
ExternalTheorem deterministic_image_char
  := @Cslib.LTS.deterministic_image_char
  : ∀ {State : Type u_1} {Label : Type u_2} (lts : LTS State Label)
    [lts.Deterministic] (s : State) (μ : Label),
    (∃ s', lts.image s μ = {s'}) ∨ lts.image s μ = ∅
