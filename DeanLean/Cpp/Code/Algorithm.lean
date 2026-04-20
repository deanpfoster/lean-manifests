import DeanLean.Basic

namespace Cpp

/-! # C++ algorithms (N4950 §27.7-27.9): min/max, clamp, sorted operations

  Formalizes basic C++ algorithms from `<algorithm>` using Lean's built-in
  `Ord` typeclass and `compare` function. All operations work on the
  three-way `Ordering` returned by `compare`.

  C++ semantics: these algorithms use a strict weak ordering via `operator<`.
  We model this using `compare a b != .gt` as the "less-than-or-equal"
  relation, which corresponds to `!(b < a)` in C++.
-/

/-! ## Lawful ordering typeclass -/

/-- A lawful `Ord` instance: reflexive, and `compare` is antisymmetric
    (swapping arguments swaps the result via `Ordering.swap`).
    This captures the properties of a total order. -/
class OrdLawful (T : Type) [Ord T] : Prop where
  /-- Comparing an element with itself yields `.eq`. -/
  compare_refl : ∀ (a : T), compare a a = Ordering.eq
  /-- `compare` is antisymmetric: swapping arguments swaps the ordering. -/
  compare_swap : ∀ (a b : T), compare a b = Ordering.swap (compare b a)
  /-- `compare` is transitive on the "not greater than" relation. -/
  compare_le_trans : ∀ (a b c : T),
    compare a b ≠ Ordering.gt → compare b c ≠ Ordering.gt →
    compare a c ≠ Ordering.gt

namespace OrdLawful

variable {T : Type} [Ord T] [OrdLawful T]

/-- If `compare a b = .lt` then `compare b a = .gt`. -/
theorem compare_lt_iff_gt (a b : T) :
    compare a b = Ordering.lt → compare b a = Ordering.gt := by
  intro hab
  have hsw := compare_swap a b; rw [hab] at hsw
  cases hba : compare b a with
  | lt => rw [hba] at hsw; exact absurd hsw (by decide)
  | eq => rw [hba] at hsw; exact absurd hsw (by decide)
  | gt => rfl

/-- If `compare a b = .eq` then `compare b a = .eq`. -/
theorem compare_eq_symm (a b : T) :
    compare a b = Ordering.eq → compare b a = Ordering.eq := by
  intro hab
  have hsw := compare_swap a b; rw [hab] at hsw
  cases hba : compare b a with
  | lt => rw [hba] at hsw; exact absurd hsw (by decide)
  | eq => rfl
  | gt => rw [hba] at hsw; exact absurd hsw (by decide)

/-- If `compare a b = .gt` then `compare b a = .lt`. -/
theorem compare_gt_iff_lt (a b : T) :
    compare a b = Ordering.gt → compare b a = Ordering.lt := by
  intro hab
  have hsw := compare_swap a b; rw [hab] at hsw
  cases hba : compare b a with
  | lt => rfl
  | eq => rw [hba] at hsw; exact absurd hsw (by decide)
  | gt => rw [hba] at hsw; exact absurd hsw (by decide)

end OrdLawful

/-- An `Ord` instance where `.eq` comparison implies actual equality.
    This holds for Nat, Int, and other types with canonical representations.
    Needed for `min_comm` and `max_comm` (since distinct objects may compare equal). -/
class OrdEqRefl (T : Type) [Ord T] : Prop where
  compare_eq_imp_eq : ∀ (a b : T), compare a b = Ordering.eq → a = b

/-! ## The ordering relation derived from compare -/

/-- `cmpLe a b` means `compare a b != .gt`, i.e., `a <= b`. -/
def cmpLe {T : Type} [Ord T] (a b : T) : Prop := compare a b ≠ Ordering.gt

/-! ## §27.8.5 min -- returns the smaller of two values -/

/-- `std::min(a, b)` -- returns `a` if `a <= b`, otherwise `b`.
    C++ returns the first argument when equal (stable). -/
def cppMin {T : Type} [Ord T] (a b : T) : T :=
  match compare a b with
  | .gt => b
  | _   => a

/-! ## §27.8.6 max -- returns the larger of two values -/

/-- `std::max(a, b)` -- returns `a` if `a >= b`, otherwise `b`.
    C++ returns the first argument when equal (stable). -/
def cppMax {T : Type} [Ord T] (a b : T) : T :=
  match compare a b with
  | .lt => b
  | _   => a

/-! ## §27.8.8 clamp -- clamps a value to a range -/

/-- `std::clamp(v, lo, hi)` -- clamps `v` to the range `[lo, hi]`.
    Precondition: `lo <= hi` (i.e., `compare lo hi != .gt`). -/
def cppClamp {T : Type} [Ord T] (v lo hi : T) : T :=
  match compare v lo with
  | .lt => lo
  | _   =>
    match compare v hi with
    | .gt => hi
    | _   => v

/-! ## §27.8.5 min_element -- minimum element of a range -/

/-- `std::min_element` on a list -- returns the minimum element.
    Returns `default` on empty list. -/
def minElement {T : Type} [Ord T] [Inhabited T] (l : List T) : T :=
  match l with
  | []      => default
  | x :: xs => xs.foldl (fun acc y => cppMin acc y) x

/-! ## §27.8.6 max_element -- maximum element of a range -/

/-- `std::max_element` on a list -- returns the maximum element.
    Returns `default` on empty list. -/
def maxElement {T : Type} [Ord T] [Inhabited T] (l : List T) : T :=
  match l with
  | []      => default
  | x :: xs => xs.foldl (fun acc y => cppMax acc y) x

/-! ## §27.8.4 is_sorted -- checks if a range is sorted -/

/-- `std::is_sorted` on a list -- returns `true` if the list is sorted
    in non-decreasing order according to `compare`. -/
def isSorted {T : Type} [Ord T] : List T → Bool
  | []  => true
  | [_] => true
  | a :: b :: rest =>
    match compare a b with
    | .gt => false
    | _   => isSorted (b :: rest)

end Cpp
