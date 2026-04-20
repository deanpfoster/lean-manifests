import DeanLean.Cpp.Code.Ordering

/-! # Proofs for C++ comparison/ordering types (N4950 §17.11)

  Proves properties of the Ordering types and StrongOrd typeclass
  that will be used downstream by FunctionObjects and Algorithm modules.
-/

namespace Cpp

variable {T : Type} [StrongOrd T]

/-! ## Ordering type properties -/

theorem flip_flip_proof (o : Ordering) : o.flip.flip = o := by
  cases o <;> rfl

theorem flip_lt_proof : Ordering.lt.flip = Ordering.gt := by rfl
theorem flip_eq_proof : Ordering.eq.flip = Ordering.eq := by rfl
theorem flip_gt_proof : Ordering.gt.flip = Ordering.lt := by rfl

theorem toWeak_lt_proof : Ordering.lt.toWeak = WeakOrdering.lt := by rfl
theorem toWeak_eq_proof : Ordering.eq.toWeak = WeakOrdering.equivalent := by rfl
theorem toWeak_gt_proof : Ordering.gt.toWeak = WeakOrdering.gt := by rfl

theorem toPartial_lt_proof : Ordering.lt.toPartial = PartialOrdering.lt := by rfl
theorem toPartial_eq_proof : Ordering.eq.toPartial = PartialOrdering.equivalent := by rfl
theorem toPartial_gt_proof : Ordering.gt.toPartial = PartialOrdering.gt := by rfl

/-! ## StrongOrd derived properties -/

/-- Reflexivity -/
theorem strongCmp_refl_proof (a : T) : StrongOrd.strongCmp a a = .eq :=
  StrongOrd.cmp_refl a

/-- Flip/antisymmetry -/
theorem strongCmp_flip_proof (a b : T) :
    (StrongOrd.strongCmp a b).flip = StrongOrd.strongCmp b a :=
  StrongOrd.cmp_flip a b

/-- Lt transitivity -/
theorem strongCmp_lt_trans_proof (a b c : T)
    (hab : StrongOrd.strongCmp a b = .lt)
    (hbc : StrongOrd.strongCmp b c = .lt) :
    StrongOrd.strongCmp a c = .lt :=
  StrongOrd.cmp_lt_trans a b c hab hbc

/-- Gt transitivity -/
theorem strongCmp_gt_trans_proof (a b c : T)
    (hab : StrongOrd.strongCmp a b = .gt)
    (hbc : StrongOrd.strongCmp b c = .gt) :
    StrongOrd.strongCmp a c = .gt :=
  StrongOrd.cmp_gt_trans a b c hab hbc

/-- Eq transitivity -/
theorem strongCmp_eq_trans_proof (a b c : T)
    (hab : StrongOrd.strongCmp a b = .eq)
    (hbc : StrongOrd.strongCmp b c = .eq) :
    StrongOrd.strongCmp a c = .eq :=
  StrongOrd.cmp_eq_trans a b c hab hbc

/-- Eq symmetry -/
theorem strongCmp_eq_symm_proof (a b : T) (h : StrongOrd.strongCmp a b = .eq) :
    StrongOrd.strongCmp b a = .eq :=
  StrongOrd.cmp_eq_symm a b h

/-- Lt-eq transitivity -/
theorem strongCmp_lt_eq_trans_proof (a b c : T)
    (hab : StrongOrd.strongCmp a b = .lt)
    (hbc : StrongOrd.strongCmp b c = .eq) :
    StrongOrd.strongCmp a c = .lt :=
  StrongOrd.cmp_lt_eq_trans a b c hab hbc

/-- Eq-lt transitivity -/
theorem strongCmp_eq_lt_trans_proof (a b c : T)
    (hab : StrongOrd.strongCmp a b = .eq)
    (hbc : StrongOrd.strongCmp b c = .lt) :
    StrongOrd.strongCmp a c = .lt :=
  StrongOrd.cmp_eq_lt_trans a b c hab hbc

/-- Trichotomy -/
theorem strongCmp_trichotomy_proof (a b : T) :
    StrongOrd.strongCmp a b = .lt ∨
    StrongOrd.strongCmp a b = .eq ∨
    StrongOrd.strongCmp a b = .gt :=
  StrongOrd.cmp_trichotomy a b

/-- Lt iff gt (symmetry) -/
theorem strongCmp_lt_iff_gt_proof (a b : T) :
    StrongOrd.strongCmp a b = .lt ↔ StrongOrd.strongCmp b a = .gt :=
  StrongOrd.cmp_lt_iff_gt a b

/-! ## Nat instance correctness -/

theorem nat_cmp_zero_zero_proof : natCmp 0 0 = .eq := by
  unfold natCmp; simp

theorem nat_cmp_lt_proof (a b : Nat) (h : a < b) : natCmp a b = .lt := by
  unfold natCmp; simp [h]

theorem nat_cmp_eq_proof (a b : Nat) (h : a = b) : natCmp a b = .eq := by
  unfold natCmp; simp [h]

theorem nat_cmp_gt_proof (a b : Nat) (h : b < a) : natCmp a b = .gt := by
  unfold natCmp
  have : ¬(a < b) := by omega
  have : ¬(a = b) := by omega
  simp [*]

/-! ## Int instance correctness -/

theorem int_cmp_zero_zero_proof : intCmp 0 0 = .eq := by
  unfold intCmp; simp

theorem int_cmp_lt_proof (a b : Int) (h : a < b) : intCmp a b = .lt := by
  unfold intCmp; simp [h]

theorem int_cmp_eq_proof (a b : Int) (h : a = b) : intCmp a b = .eq := by
  unfold intCmp; simp [h]

theorem int_cmp_gt_proof (a b : Int) (h : b < a) : intCmp a b = .gt := by
  unfold intCmp
  have : ¬(a < b) := by omega
  have : ¬(a = b) := by omega
  simp [*]

/-! ## Pair lexicographic ordering properties -/

variable {T1 T2 : Type} [StrongOrd T1] [StrongOrd T2]

/-- Lexicographic ordering: if first components are lt, result is lt -/
theorem pair_cmp_first_lt_proof (p q : Pair T1 T2)
    (h : StrongOrd.strongCmp p.first q.first = .lt) :
    StrongOrd.strongCmp p q = .lt := by
  show pairCmp p q = .lt
  unfold pairCmp; rw [h]

/-- Lexicographic ordering: if first components are gt, result is gt -/
theorem pair_cmp_first_gt_proof (p q : Pair T1 T2)
    (h : StrongOrd.strongCmp p.first q.first = .gt) :
    StrongOrd.strongCmp p q = .gt := by
  show pairCmp p q = .gt
  unfold pairCmp; rw [h]

/-- Lexicographic ordering: if first components are eq, result depends on second -/
theorem pair_cmp_first_eq_proof (p q : Pair T1 T2)
    (h : StrongOrd.strongCmp p.first q.first = .eq) :
    StrongOrd.strongCmp p q = StrongOrd.strongCmp p.second q.second := by
  show pairCmp p q = _
  unfold pairCmp; rw [h]

/-- Pair equality means both components are eq -/
theorem pair_cmp_eq_iff_proof (p q : Pair T1 T2) :
    StrongOrd.strongCmp p q = .eq ↔
    (StrongOrd.strongCmp p.first q.first = .eq ∧
     StrongOrd.strongCmp p.second q.second = .eq) := by
  change pairCmp p q = .eq ↔ _
  unfold pairCmp
  constructor
  · intro h
    cases hf : StrongOrd.strongCmp p.first q.first with
    | lt => simp [hf] at h
    | eq => simp [hf] at h; exact ⟨rfl, h⟩
    | gt => simp [hf] at h
  · intro ⟨h1, h2⟩; simp [h1, h2]

end Cpp
