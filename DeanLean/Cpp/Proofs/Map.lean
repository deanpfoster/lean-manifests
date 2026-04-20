import DeanLean.Cpp.Code.Map

/-! # Proofs for C++ sorted associative containers (N4950 §24.4)

  Proves properties of Map and CppSet operations:
  - find after insert (same key / different key)
  - find on empty map
  - erase then find
  - contains ↔ find
  - size of empty
  - keys are sorted
-/

namespace Cpp

variable {K : Type} {V : Type} [StrongOrd K]

/-! ## Map: find after insert (same key) -/

/-- Helper: findAux k (insertAux k v l) = some v for sorted l -/
private theorem findAux_insertAux_same (k : K) (v : V) (l : List (K × V))
    (hs : SortedPairs l) :
    Map.findAux k (Map.insertAux k v l) = some v := by
  induction l with
  | nil =>
    simp [Map.insertAux, Map.findAux, StrongOrd.cmp_refl]
  | cons p tl ih =>
    obtain ⟨k', v'⟩ := p
    simp only [Map.insertAux]
    cases hcmp : StrongOrd.strongCmp k k' with
    | lt =>
      simp [Map.findAux, StrongOrd.cmp_refl]
    | eq =>
      simp [Map.findAux, StrongOrd.cmp_refl]
    | gt =>
      simp only [Map.findAux, hcmp]
      cases tl with
      | nil => simp [Map.insertAux, Map.findAux, StrongOrd.cmp_refl]
      | cons q tl' =>
        simp only [SortedPairs] at hs
        exact ih hs.2

theorem find_insert_same_proof (m : Map K V) (k : K) (v : V) :
    (m.insert k v).find k = some v := by
  simp only [Map.insert, Map.find]
  exact findAux_insertAux_same k v m.entries m.sorted

/-! ## Map: find after insert (different key) -/

/-- Helper: findAux k₂ (insertAux k₁ v l) = findAux k₂ l when k₁ ≠ k₂ -/
private theorem findAux_insertAux_other (k₁ k₂ : K) (v : V) (l : List (K × V))
    (hne : StrongOrd.strongCmp k₁ k₂ ≠ .eq)
    (hs : SortedPairs l) :
    Map.findAux k₂ (Map.insertAux k₁ v l) = Map.findAux k₂ l := by
  induction l with
  | nil =>
    simp only [Map.insertAux, Map.findAux]
    have hne_sym : StrongOrd.strongCmp k₂ k₁ ≠ .eq := by
      intro h
      exact hne (StrongOrd.cmp_eq_symm k₂ k₁ h)
    cases hcmp : StrongOrd.strongCmp k₂ k₁ with
    | lt => simp [Map.findAux]
    | eq => exact absurd hcmp hne_sym
    | gt => simp [Map.findAux]
  | cons p tl ih =>
    obtain ⟨k', v'⟩ := p
    simp only [Map.insertAux]
    cases hcmp1 : StrongOrd.strongCmp k₁ k' with
    | lt =>
      -- insertAux returns (k₁, v) :: (k', v') :: tl
      simp only [Map.findAux]
      cases hcmp2 : StrongOrd.strongCmp k₂ k₁ with
      | lt =>
        -- k₂ < k₁, so findAux returns none
        -- On the right: findAux k₂ ((k', v') :: tl) — k₂ < k₁ < k', so also none
        simp only [Map.findAux]
        have : StrongOrd.strongCmp k₂ k' = .lt :=
          StrongOrd.cmp_lt_trans k₂ k₁ k' hcmp2 hcmp1
        simp [this]
      | eq =>
        have : StrongOrd.strongCmp k₁ k₂ = .eq :=
          StrongOrd.cmp_eq_symm k₂ k₁ hcmp2
        exact absurd this hne
      | gt =>
        -- k₂ > k₁, skip the inserted element, same as original
        simp
    | eq =>
      -- insertAux returns (k₁, v) :: tl
      -- We need: findAux k₂ ((k₁, v) :: tl) = findAux k₂ ((k', v') :: tl)
      simp only [Map.findAux]
      -- k₁ and k' are "equal" in the ordering
      have hk'k₁ : StrongOrd.strongCmp k' k₁ = .eq :=
        StrongOrd.flip_eq_means_eq k₁ k' hcmp1
      -- We need to show the match results are the same
      -- Case on strongCmp k₂ k₁ and strongCmp k₂ k'
      have hne_sym : StrongOrd.strongCmp k₂ k₁ ≠ .eq := by
        intro h; exact hne (StrongOrd.cmp_eq_symm k₂ k₁ h)
      cases hcmp2 : StrongOrd.strongCmp k₂ k₁ with
      | lt =>
        simp only [Map.findAux]
        -- k₂ < k₁ and k₁ = k', so k₂ < k'
        have : StrongOrd.strongCmp k₂ k' = .lt :=
          StrongOrd.cmp_lt_eq_trans k₂ k₁ k' hcmp2 hcmp1
        simp [this]
      | eq => exact absurd hcmp2 hne_sym
      | gt =>
        simp only [Map.findAux]
        -- k₂ > k₁ and k₁ = k', so k₂ > k'
        have : StrongOrd.strongCmp k₂ k' = .gt :=
          StrongOrd.cmp_gt_eq_trans k₂ k₁ k' hcmp2 hcmp1
        simp [this]
    | gt =>
      -- insertAux returns (k', v') :: insertAux k₁ v tl
      simp only [Map.findAux]
      cases hcmp2 : StrongOrd.strongCmp k₂ k' with
      | lt => rfl
      | eq => rfl
      | gt =>
        cases tl with
        | nil => exact ih True.intro
        | cons q tl' =>
          simp only [SortedPairs] at hs
          exact ih hs.2

theorem find_insert_other_proof (m : Map K V) (k₁ k₂ : K) (v : V)
    (hne : StrongOrd.strongCmp k₁ k₂ ≠ .eq) :
    (m.insert k₁ v).find k₂ = m.find k₂ := by
  simp only [Map.insert, Map.find]
  exact findAux_insertAux_other k₁ k₂ v m.entries hne m.sorted

/-! ## Map: find on empty -/

theorem find_empty_proof (k : K) : (Map.empty : Map K V).find k = none := by
  simp [Map.empty, Map.find, Map.findAux]

/-! ## Map: contains iff find -/

theorem contains_iff_find_proof (m : Map K V) (k : K) :
    m.contains k = true ↔ ∃ v, m.find k = some v := by
  simp only [Map.contains]
  constructor
  · intro h
    cases hf : m.find k with
    | none => simp [hf] at h
    | some v => exact ⟨v, rfl⟩
  · intro ⟨v, hv⟩
    simp [hv]

/-! ## Map: size of empty -/

theorem size_empty_proof : (Map.empty : Map K V).size = 0 := by
  simp [Map.empty, Map.size]

/-! ## Map: erase then find -/

/-- Helper: findAux k (eraseAux k l) = none for sorted l -/
private theorem findAux_eraseAux_same (k : K) (l : List (K × V))
    (hs : SortedPairs l) :
    Map.findAux k (Map.eraseAux k l) = none := by
  induction l with
  | nil => simp [Map.eraseAux, Map.findAux]
  | cons p tl ih =>
    obtain ⟨k', v'⟩ := p
    simp only [Map.eraseAux]
    cases hcmp : StrongOrd.strongCmp k k' with
    | lt =>
      simp [Map.findAux, hcmp]
    | eq =>
      cases tl with
      | nil => simp [Map.findAux]
      | cons q tl' =>
        obtain ⟨k'', v''⟩ := q
        have hlt : StrongOrd.strongCmp k' k'' = .lt := by
          simp only [SortedPairs] at hs; exact hs.1
        have hk_k'' : StrongOrd.strongCmp k k'' = .lt :=
          StrongOrd.cmp_eq_lt_trans k k' k'' hcmp hlt
        simp [Map.findAux, hk_k'']
    | gt =>
      simp only [Map.findAux, hcmp]
      cases tl with
      | nil => simp [Map.eraseAux, Map.findAux]
      | cons q tl' =>
        simp only [SortedPairs] at hs
        exact ih hs.2

theorem erase_find_proof (m : Map K V) (k : K) :
    (m.erase k).find k = none := by
  simp only [Map.erase, Map.find]
  exact findAux_eraseAux_same k m.entries m.sorted

/-! ## Map: keys are sorted (SortedKeys from SortedPairs) -/

/-- The keys extracted from a SortedPairs list form a SortedKeys list -/
theorem keys_of_sorted_pairs (l : List (K × V))
    (hs : SortedPairs l) : SortedKeys (l.map Prod.fst) := by
  induction l with
  | nil => simp [SortedKeys]
  | cons p tl ih =>
    obtain ⟨k, v⟩ := p
    cases tl with
    | nil => simp [SortedKeys]
    | cons q tl' =>
      obtain ⟨k', v'⟩ := q
      simp only [SortedPairs] at hs
      obtain ⟨hlt, hsrest⟩ := hs
      simp only [List.map]
      exact ⟨hlt, ih hsrest⟩

theorem keys_sorted_proof (m : Map K V) : SortedKeys m.keys := by
  simp only [Map.keys]
  exact keys_of_sorted_pairs m.entries m.sorted

/-! ## CppSet: contains after insert -/

/-- Helper: findAux k (insertAux k l) = true for sorted l -/
private theorem set_findAux_insertAux_same (k : K) (l : List K)
    (hs : SortedKeys l) :
    CppSet.findAux k (CppSet.insertAux k l) = true := by
  induction l with
  | nil =>
    simp [CppSet.insertAux, CppSet.findAux, StrongOrd.cmp_refl]
  | cons k' tl ih =>
    simp only [CppSet.insertAux]
    cases hcmp : StrongOrd.strongCmp k k' with
    | lt =>
      simp [CppSet.findAux, StrongOrd.cmp_refl]
    | eq =>
      simp only [CppSet.findAux, hcmp]
    | gt =>
      simp only [CppSet.findAux, hcmp]
      cases tl with
      | nil => simp [CppSet.insertAux, CppSet.findAux, StrongOrd.cmp_refl]
      | cons k'' tl' =>
        simp only [SortedKeys] at hs
        exact ih hs.2

theorem contains_insert_proof (s : CppSet K) (k : K) :
    (s.insert k).contains k = true := by
  simp only [CppSet.insert, CppSet.contains]
  exact set_findAux_insertAux_same k s.elems s.sorted

/-! ## CppSet: contains after erase -/

/-- Helper: findAux k (eraseAux k l) = false for sorted l -/
private theorem set_findAux_eraseAux_same (k : K) (l : List K)
    (hs : SortedKeys l) :
    CppSet.findAux k (CppSet.eraseAux k l) = false := by
  induction l with
  | nil => simp [CppSet.eraseAux, CppSet.findAux]
  | cons k' tl ih =>
    simp only [CppSet.eraseAux]
    cases hcmp : StrongOrd.strongCmp k k' with
    | lt =>
      simp [CppSet.findAux, hcmp]
    | eq =>
      cases tl with
      | nil => simp [CppSet.findAux]
      | cons k'' tl' =>
        have hlt : StrongOrd.strongCmp k' k'' = .lt := by
          simp only [SortedKeys] at hs; exact hs.1
        have hk_k'' : StrongOrd.strongCmp k k'' = .lt :=
          StrongOrd.cmp_eq_lt_trans k k' k'' hcmp hlt
        simp [CppSet.findAux, hk_k'']
    | gt =>
      simp only [CppSet.findAux, hcmp]
      cases tl with
      | nil => simp [CppSet.eraseAux, CppSet.findAux]
      | cons k'' tl' =>
        simp only [SortedKeys] at hs
        exact ih hs.2

theorem contains_erase_proof (s : CppSet K) (k : K) :
    (s.erase k).contains k = false := by
  simp only [CppSet.erase, CppSet.contains]
  exact set_findAux_eraseAux_same k s.elems s.sorted

/-! ## CppSet: insert preserves other elements -/

/-- Helper: findAux k₂ (insertAux k₁ l) = findAux k₂ l when k₁ ≠ k₂ -/
private theorem set_findAux_insertAux_other (k₁ k₂ : K) (l : List K)
    (hne : StrongOrd.strongCmp k₁ k₂ ≠ .eq)
    (hs : SortedKeys l) :
    CppSet.findAux k₂ (CppSet.insertAux k₁ l) = CppSet.findAux k₂ l := by
  induction l with
  | nil =>
    simp only [CppSet.insertAux, CppSet.findAux]
    have hne_sym : StrongOrd.strongCmp k₂ k₁ ≠ .eq := by
      intro h; exact hne (StrongOrd.cmp_eq_symm k₂ k₁ h)
    cases hcmp : StrongOrd.strongCmp k₂ k₁ with
    | lt => simp [CppSet.findAux]
    | eq => exact absurd hcmp hne_sym
    | gt => simp [CppSet.findAux]
  | cons k' tl ih =>
    simp only [CppSet.insertAux]
    cases hcmp1 : StrongOrd.strongCmp k₁ k' with
    | lt =>
      simp only [CppSet.findAux]
      cases hcmp2 : StrongOrd.strongCmp k₂ k₁ with
      | lt =>
        simp only [CppSet.findAux]
        have : StrongOrd.strongCmp k₂ k' = .lt :=
          StrongOrd.cmp_lt_trans k₂ k₁ k' hcmp2 hcmp1
        simp [this]
      | eq =>
        have : StrongOrd.strongCmp k₁ k₂ = .eq :=
          StrongOrd.cmp_eq_symm k₂ k₁ hcmp2
        exact absurd this hne
      | gt =>
        simp
    | eq =>
      -- insertAux returns k' :: tl (unchanged for Set)
      rfl
    | gt =>
      simp only [CppSet.findAux]
      cases hcmp2 : StrongOrd.strongCmp k₂ k' with
      | lt => rfl
      | eq => rfl
      | gt =>
        cases tl with
        | nil => exact ih True.intro
        | cons k'' tl' =>
          simp only [SortedKeys] at hs
          exact ih hs.2

theorem contains_insert_other_proof (s : CppSet K) (k₁ k₂ : K)
    (hne : StrongOrd.strongCmp k₁ k₂ ≠ .eq) :
    (s.insert k₁).contains k₂ = s.contains k₂ := by
  simp only [CppSet.insert, CppSet.contains]
  exact set_findAux_insertAux_other k₁ k₂ s.elems hne s.sorted

end Cpp
