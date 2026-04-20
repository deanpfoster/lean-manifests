import DeanLean.Cpp.Code.Algorithm

namespace Cpp

/-! # Proofs for C++ algorithm formalizations (N4950 §27.7-27.9)

  Proven properties of min, max, clamp, isSorted, minElement, maxElement.
  These use `compare` and the `OrdLawful` / `OrdEqRefl` typeclasses
  where symmetry, transitivity, or equality reflection is needed.
-/

variable {T : Type} [Ord T]

/-! ## Reflexivity and transitivity of cmpLe -/

theorem cmpLe_refl_proof [OrdLawful T] (a : T) : cmpLe a a := by
  unfold cmpLe; rw [OrdLawful.compare_refl]; decide

theorem cmpLe_trans_proof [OrdLawful T] (a b c : T) :
    cmpLe a b → cmpLe b c → cmpLe a c :=
  OrdLawful.compare_le_trans a b c

/-! ## cppMin properties -/

/-- `cppMin a b` is either `a` or `b`. -/
theorem cppMin_cases_proof (a b : T) : cppMin a b = a ∨ cppMin a b = b := by
  unfold cppMin
  cases compare a b with
  | lt => left; rfl
  | eq => left; rfl
  | gt => right; rfl

/-- `cppMin a b ≤ a` (in the `cmpLe` sense). -/
theorem cppMin_le_left_proof [OrdLawful T] (a b : T) :
    cmpLe (cppMin a b) a := by
  unfold cppMin cmpLe
  cases hab : compare a b with
  | lt => rw [OrdLawful.compare_refl]; decide
  | eq => rw [OrdLawful.compare_refl]; decide
  | gt => rw [OrdLawful.compare_gt_iff_lt a b hab]; decide

/-- `cppMin a b ≤ b` (in the `cmpLe` sense). -/
theorem cppMin_le_right_proof [OrdLawful T] (a b : T) :
    cmpLe (cppMin a b) b := by
  unfold cppMin cmpLe
  cases hab : compare a b with
  | lt => rw [hab]; decide
  | eq => rw [hab]; decide
  | gt => rw [OrdLawful.compare_refl]; decide

/-- `cppMin a a = a` for any `a`, given a lawful ordering. -/
theorem cppMin_self_proof [OrdLawful T] (a : T) : cppMin a a = a := by
  unfold cppMin; rw [OrdLawful.compare_refl]

/-- `cppMin` is commutative when the ordering is lawful and equality-reflecting. -/
theorem cppMin_comm_proof [OrdLawful T] [OrdEqRefl T] (a b : T) :
    cppMin a b = cppMin b a := by
  unfold cppMin
  cases hab : compare a b with
  | lt => rw [OrdLawful.compare_lt_iff_gt a b hab]
  | eq =>
    have heq := OrdEqRefl.compare_eq_imp_eq a b hab
    subst heq; rw [OrdLawful.compare_refl]
  | gt => rw [OrdLawful.compare_gt_iff_lt a b hab]

/-! ## cppMax properties -/

/-- `cppMax a b` is either `a` or `b`. -/
theorem cppMax_cases_proof (a b : T) : cppMax a b = a ∨ cppMax a b = b := by
  unfold cppMax
  cases compare a b with
  | lt => right; rfl
  | eq => left; rfl
  | gt => left; rfl

/-- `a ≤ cppMax a b` (in the `cmpLe` sense). -/
theorem cppMax_ge_left_proof [OrdLawful T] (a b : T) :
    cmpLe a (cppMax a b) := by
  unfold cppMax cmpLe
  cases hab : compare a b with
  | lt =>
    -- max = b, need compare a b ≠ .gt
    rw [hab]; decide
  | eq =>
    -- max = a, need compare a a ≠ .gt
    rw [OrdLawful.compare_refl]; decide
  | gt =>
    -- max = a, need compare a a ≠ .gt
    rw [OrdLawful.compare_refl]; decide

/-- `b ≤ cppMax a b` (in the `cmpLe` sense). -/
theorem cppMax_ge_right_proof [OrdLawful T] (a b : T) :
    cmpLe b (cppMax a b) := by
  unfold cppMax cmpLe
  cases hab : compare a b with
  | lt =>
    -- max = b
    rw [OrdLawful.compare_refl]; decide
  | eq =>
    -- max = a, need compare b a ≠ .gt
    have := OrdLawful.compare_eq_symm a b hab
    rw [this]; decide
  | gt =>
    -- max = a, need compare b a ≠ .gt
    rw [OrdLawful.compare_gt_iff_lt a b hab]; decide

/-- `cppMax a a = a` for any `a`, given a lawful ordering. -/
theorem cppMax_self_proof [OrdLawful T] (a : T) : cppMax a a = a := by
  unfold cppMax; rw [OrdLawful.compare_refl]

/-- `cppMax` is commutative when the ordering is lawful and equality-reflecting. -/
theorem cppMax_comm_proof [OrdLawful T] [OrdEqRefl T] (a b : T) :
    cppMax a b = cppMax b a := by
  unfold cppMax
  cases hab : compare a b with
  | lt => rw [OrdLawful.compare_lt_iff_gt a b hab]
  | eq =>
    have heq := OrdEqRefl.compare_eq_imp_eq a b hab
    subst heq; rw [OrdLawful.compare_refl]
  | gt => rw [OrdLawful.compare_gt_iff_lt a b hab]

/-! ## cppClamp properties -/

/-- The result of `cppClamp` is always one of `lo`, `hi`, or `v`. -/
theorem cppClamp_trichotomy_proof (v lo hi : T) :
    cppClamp v lo hi = lo ∨ cppClamp v lo hi = hi ∨ cppClamp v lo hi = v := by
  unfold cppClamp
  cases compare v lo with
  | lt => left; rfl
  | eq =>
    cases compare v hi with
    | lt => right; right; rfl
    | eq => right; right; rfl
    | gt => right; left; rfl
  | gt =>
    cases compare v hi with
    | lt => right; right; rfl
    | eq => right; right; rfl
    | gt => right; left; rfl

/-- `cppClamp` returns a value in `[lo, hi]` (given `lo ≤ hi`). -/
theorem cppClamp_in_range_proof [OrdLawful T] (v lo hi : T)
    (hlohi : cmpLe lo hi) :
    cmpLe lo (cppClamp v lo hi) ∧ cmpLe (cppClamp v lo hi) hi := by
  unfold cppClamp
  cases hvlo : compare v lo with
  | lt =>
    -- result is lo
    exact ⟨cmpLe_refl_proof lo, hlohi⟩
  | eq =>
    -- compare v lo ≠ .lt, fallthrough to inner match
    cases hvhi : compare v hi with
    | lt =>
      -- result is v
      constructor
      · unfold cmpLe; rw [OrdLawful.compare_eq_symm v lo hvlo]; decide
      · unfold cmpLe; rw [hvhi]; decide
    | eq =>
      -- result is v
      constructor
      · unfold cmpLe; rw [OrdLawful.compare_eq_symm v lo hvlo]; decide
      · unfold cmpLe; rw [hvhi]; decide
    | gt =>
      -- result is hi
      exact ⟨hlohi, cmpLe_refl_proof hi⟩
  | gt =>
    cases hvhi : compare v hi with
    | lt =>
      -- result is v
      constructor
      · unfold cmpLe; rw [OrdLawful.compare_gt_iff_lt v lo hvlo]; decide
      · unfold cmpLe; rw [hvhi]; decide
    | eq =>
      -- result is v
      constructor
      · unfold cmpLe; rw [OrdLawful.compare_gt_iff_lt v lo hvlo]; decide
      · unfold cmpLe; rw [hvhi]; decide
    | gt =>
      -- result is hi
      exact ⟨hlohi, cmpLe_refl_proof hi⟩

/-- `cppClamp lo lo hi = lo` (assuming `lo ≤ hi`). -/
theorem cppClamp_lo_proof [OrdLawful T] (lo hi : T)
    (h : cmpLe lo hi) : cppClamp lo lo hi = lo := by
  unfold cppClamp
  cases hll : compare lo lo with
  | lt => rfl
  | eq =>
    cases hlh : compare lo hi with
    | lt => rfl
    | eq => rfl
    | gt => exact absurd hlh h
  | gt => have := OrdLawful.compare_refl lo; rw [this] at hll; exact absurd hll (by decide)

/-- `cppClamp hi lo hi = hi` (assuming `lo ≤ hi`). -/
theorem cppClamp_hi_proof [OrdLawful T] (lo hi : T)
    (h : cmpLe lo hi) : cppClamp hi lo hi = hi := by
  unfold cppClamp
  cases hhl : compare hi lo with
  | lt => have := OrdLawful.compare_lt_iff_gt hi lo hhl; exact absurd this h
  | eq => rw [OrdLawful.compare_refl]
  | gt => rw [OrdLawful.compare_refl]

/-! ## isSorted properties -/

/-- An empty list is sorted. -/
theorem isSorted_nil_proof : isSorted ([] : List T) = true := rfl

/-- A singleton list is sorted. -/
theorem isSorted_singleton_proof (a : T) : isSorted [a] = true := rfl

/-- If `a :: b :: l` is sorted, then `compare a b ≠ .gt`. -/
theorem isSorted_cons_proof (a b : T) (l : List T) :
    isSorted (a :: b :: l) = true → compare a b ≠ Ordering.gt := by
  intro h hgt
  simp [isSorted, hgt] at h

/-- If `a :: b :: l` is sorted, then `b :: l` is sorted. -/
theorem isSorted_tail_proof (a b : T) (l : List T) :
    isSorted (a :: b :: l) = true → isSorted (b :: l) = true := by
  intro h
  simp [isSorted] at h
  cases hab : compare a b with
  | lt => simp [hab] at h; exact h
  | eq => simp [hab] at h; exact h
  | gt => simp [hab] at h

/-! ## minElement properties -/

/-- Helper: `foldl cppMin` yields the initial accumulator or an element of the list. -/
theorem foldl_cppMin_mem_proof (x : T) (xs : List T) :
    List.foldl (fun acc y => cppMin acc y) x xs = x ∨
    List.foldl (fun acc y => cppMin acc y) x xs ∈ xs := by
  induction xs generalizing x with
  | nil => left; rfl
  | cons y ys ih =>
    simp [List.foldl]
    have h := ih (cppMin x y)
    cases h with
    | inl heq =>
      rw [heq]
      have hcases : cppMin x y = x ∨ cppMin x y = y := by
        unfold cppMin; cases compare x y <;> simp
      cases hcases with
      | inl hl => left; exact hl
      | inr hr => right; left; exact hr
    | inr hmem =>
      right; right; exact hmem

/-- `minElement l` is a member of `l` when `l` is nonempty. -/
theorem minElement_mem_proof [Inhabited T] (l : List T) (hl : l ≠ []) :
    minElement l ∈ l := by
  match l, hl with
  | x :: xs, _ =>
    show List.foldl (fun acc y => cppMin acc y) x xs ∈ x :: xs
    have h := foldl_cppMin_mem_proof x xs
    cases h with
    | inl heq => rw [heq]; exact List.Mem.head xs
    | inr hmem => exact List.Mem.tail x hmem

/-- Helper: `foldl cppMin` result is ≤ the initial accumulator. -/
theorem foldl_cppMin_le_init_proof [OrdLawful T] (init : T) (xs : List T) :
    cmpLe (List.foldl (fun acc y => cppMin acc y) init xs) init := by
  induction xs generalizing init with
  | nil => exact cmpLe_refl_proof init
  | cons y ys ih =>
    simp [List.foldl]
    exact cmpLe_trans_proof _ _ _ (ih (cppMin init y)) (cppMin_le_left_proof init y)

/-- Helper: `foldl cppMin` result is ≤ every element in the list. -/
theorem foldl_cppMin_le_all_proof [OrdLawful T] (init : T) (xs : List T) :
    ∀ (y : T), y ∈ xs → cmpLe (List.foldl (fun acc y => cppMin acc y) init xs) y := by
  induction xs generalizing init with
  | nil => intro y hy; exact absurd hy (List.not_mem_nil y)
  | cons z zs ih =>
    intro y hy
    simp [List.foldl]
    cases hy with
    | head =>
      exact cmpLe_trans_proof _ _ _
        (foldl_cppMin_le_init_proof (cppMin init z) zs)
        (cppMin_le_right_proof init z)
    | tail _ hmem =>
      exact ih (cppMin init z) y hmem

/-- `minElement l` is ≤ every element of `l` (given `OrdLawful`). -/
theorem minElement_le_proof [Inhabited T] [OrdLawful T] (l : List T) (hl : l ≠ []) :
    ∀ (x : T), x ∈ l → cmpLe (minElement l) x := by
  match l, hl with
  | z :: zs, _ =>
    intro x hx
    show cmpLe (List.foldl (fun acc y => cppMin acc y) z zs) x
    cases hx with
    | head => exact foldl_cppMin_le_init_proof z zs
    | tail _ hmem => exact foldl_cppMin_le_all_proof z zs x hmem

/-! ## Nat and Int instances of OrdLawful -/

private theorem nat_compare_lt {a b : Nat} (h : a < b) :
    @compare Nat instOrdNat a b = .lt := by
  show compareOfLessAndEq a b = .lt
  unfold compareOfLessAndEq; rw [if_pos h]

private theorem nat_compare_eq {a b : Nat} (h : a = b) :
    @compare Nat instOrdNat a b = .eq := by
  show compareOfLessAndEq a b = .eq
  unfold compareOfLessAndEq; rw [if_neg (by omega), if_pos h]

private theorem nat_compare_gt {a b : Nat} (h1 : ¬ a < b) (h2 : a ≠ b) :
    @compare Nat instOrdNat a b = .gt := by
  show compareOfLessAndEq a b = .gt
  unfold compareOfLessAndEq; rw [if_neg h1, if_neg h2]

instance : OrdLawful Nat where
  compare_refl := by intro a; exact nat_compare_eq rfl
  compare_swap := by
    intro a b
    by_cases hab : a < b
    · rw [nat_compare_lt hab, nat_compare_gt (by omega) (by omega)]; rfl
    · by_cases habe : a = b
      · rw [nat_compare_eq habe, nat_compare_eq (by omega)]; rfl
      · rw [nat_compare_gt hab habe, nat_compare_lt (by omega)]; rfl
  compare_le_trans := by
    intro a b c hab hbc
    by_cases h1 : a < b
    · by_cases h2 : b < c
      · rw [nat_compare_lt (by omega)]; decide
      · by_cases h2e : b = c
        · rw [nat_compare_lt (by omega)]; decide
        · rw [nat_compare_gt h2 h2e] at hbc; exact absurd rfl hbc
    · by_cases h1e : a = b
      · subst h1e; exact hbc
      · rw [nat_compare_gt h1 h1e] at hab; exact absurd rfl hab

instance : OrdEqRefl Nat where
  compare_eq_imp_eq := by
    intro a b h
    -- h : compare a b = .eq, which is compareOfLessAndEq a b = .eq
    by_cases hab : a < b
    · rw [nat_compare_lt hab] at h; exact absurd h (by decide)
    · by_cases habe : a = b
      · exact habe
      · rw [nat_compare_gt hab habe] at h; exact absurd h (by decide)

end Cpp
