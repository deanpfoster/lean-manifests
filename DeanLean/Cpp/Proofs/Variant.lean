import DeanLean.Cpp.Code.Variant

namespace Cpp.Variant2

variable {T1 T2 : Type}

-- index correctness
theorem index_first_proof (v : T1) :
    (Variant2.first v : Variant2 T1 T2).index = ⟨0, by omega⟩ := by rfl

theorem index_second_proof (v : T2) :
    (Variant2.second v : Variant2 T1 T2).index = ⟨1, by omega⟩ := by rfl

-- holds_alternative correctness
theorem holds_alternative_first_0_proof (v : T1) :
    (Variant2.first v : Variant2 T1 T2).holds_alternative ⟨0, by omega⟩ = true := by rfl

theorem holds_alternative_first_1_proof (v : T1) :
    (Variant2.first v : Variant2 T1 T2).holds_alternative ⟨1, by omega⟩ = false := by rfl

theorem holds_alternative_second_1_proof (v : T2) :
    (Variant2.second v : Variant2 T1 T2).holds_alternative ⟨1, by omega⟩ = true := by rfl

theorem holds_alternative_second_0_proof (v : T2) :
    (Variant2.second v : Variant2 T1 T2).holds_alternative ⟨0, by omega⟩ = false := by rfl

-- get roundtrips: constructing then getting back yields the original value
theorem get_first_roundtrip_proof (v : T1) :
    let w : Variant2 T1 T2 := Variant2.first v
    w.get_first (index_first_proof v) = v := by rfl

theorem get_second_roundtrip_proof (v : T2) :
    let w : Variant2 T1 T2 := Variant2.second v
    w.get_second (index_second_proof v) = v := by rfl

-- visit roundtrips: visit after constructing applies the right function
theorem visit_first_proof (v : T1) {R : Type} (f1 : T1 → R) (f2 : T2 → R) :
    (Variant2.first v : Variant2 T1 T2).visit f1 f2 = f1 v := by rfl

theorem visit_second_proof (v : T2) {R : Type} (f1 : T1 → R) (f2 : T2 → R) :
    (Variant2.second v : Variant2 T1 T2).visit f1 f2 = f2 v := by rfl

-- visit composition: visit (g . f1) (g . f2) = g . visit f1 f2
theorem visit_compose_proof {R S : Type} (f1 : T1 → R) (f2 : T2 → R) (g : R → S)
    (w : Variant2 T1 T2) :
    w.visit (g ∘ f1) (g ∘ f2) = g (w.visit f1 f2) := by
  cases w <;> rfl

-- valueless_by_exception is always false in pure setting
theorem valueless_by_exception_false_proof (w : Variant2 T1 T2) :
    w.valueless_by_exception = false := by rfl

-- variant_size
theorem variant_size_eq_proof (w : Variant2 T1 T2) : w.variant_size = 2 := by rfl

end Cpp.Variant2

namespace Cpp.Variant3

variable {T1 T2 T3 : Type}

-- index correctness
theorem index_first_proof (v : T1) :
    (Variant3.first v : Variant3 T1 T2 T3).index = ⟨0, by omega⟩ := by rfl

theorem index_second_proof (v : T2) :
    (Variant3.second v : Variant3 T1 T2 T3).index = ⟨1, by omega⟩ := by rfl

theorem index_third_proof (v : T3) :
    (Variant3.third v : Variant3 T1 T2 T3).index = ⟨2, by omega⟩ := by rfl

-- holds_alternative correctness
theorem holds_alternative_first_0_proof (v : T1) :
    (Variant3.first v : Variant3 T1 T2 T3).holds_alternative ⟨0, by omega⟩ = true := by rfl

theorem holds_alternative_second_1_proof (v : T2) :
    (Variant3.second v : Variant3 T1 T2 T3).holds_alternative ⟨1, by omega⟩ = true := by rfl

theorem holds_alternative_third_2_proof (v : T3) :
    (Variant3.third v : Variant3 T1 T2 T3).holds_alternative ⟨2, by omega⟩ = true := by rfl

-- get roundtrips
theorem get_first_roundtrip_proof (v : T1) :
    let w : Variant3 T1 T2 T3 := Variant3.first v
    w.get_first (index_first_proof v) = v := by rfl

theorem get_second_roundtrip_proof (v : T2) :
    let w : Variant3 T1 T2 T3 := Variant3.second v
    w.get_second (index_second_proof v) = v := by rfl

theorem get_third_roundtrip_proof (v : T3) :
    let w : Variant3 T1 T2 T3 := Variant3.third v
    w.get_third (index_third_proof v) = v := by rfl

-- visit roundtrips
theorem visit_first_proof (v : T1) {R : Type} (f1 : T1 → R) (f2 : T2 → R) (f3 : T3 → R) :
    (Variant3.first v : Variant3 T1 T2 T3).visit f1 f2 f3 = f1 v := by rfl

theorem visit_second_proof (v : T2) {R : Type} (f1 : T1 → R) (f2 : T2 → R) (f3 : T3 → R) :
    (Variant3.second v : Variant3 T1 T2 T3).visit f1 f2 f3 = f2 v := by rfl

theorem visit_third_proof (v : T3) {R : Type} (f1 : T1 → R) (f2 : T2 → R) (f3 : T3 → R) :
    (Variant3.third v : Variant3 T1 T2 T3).visit f1 f2 f3 = f3 v := by rfl

-- visit composition
theorem visit_compose_proof {R S : Type} (f1 : T1 → R) (f2 : T2 → R) (f3 : T3 → R) (g : R → S)
    (w : Variant3 T1 T2 T3) :
    w.visit (g ∘ f1) (g ∘ f2) (g ∘ f3) = g (w.visit f1 f2 f3) := by
  cases w <;> rfl

-- valueless_by_exception is always false
theorem valueless_by_exception_false_proof (w : Variant3 T1 T2 T3) :
    w.valueless_by_exception = false := by rfl

-- variant_size
theorem variant_size_eq_proof (w : Variant3 T1 T2 T3) : w.variant_size = 3 := by rfl

end Cpp.Variant3
