import DeanLean.Cpp.Code.Pair

namespace Cpp.Pair

variable {T1 T2 U1 U2 : Type}

theorem swap_swap_proof (p : Pair T1 T2) : p.swap.swap = p := by
  cases p; rfl

theorem swap_first_proof (p : Pair T1 T2) : p.swap.first = p.second := by
  cases p; rfl

theorem swap_second_proof (p : Pair T1 T2) : p.swap.second = p.first := by
  cases p; rfl

theorem make_first_proof (a : T1) (b : T2) : (Pair.make a b).first = a := by rfl

theorem make_second_proof (a : T1) (b : T2) : (Pair.make a b).second = b := by rfl

theorem eq_iff_components_proof (p q : Pair T1 T2) :
    p = q ↔ p.first = q.first ∧ p.second = q.second := by
  constructor
  · intro h; subst h; exact ⟨rfl, rfl⟩
  · intro ⟨h1, h2⟩; cases p; cases q; simp at *; exact ⟨h1, h2⟩

theorem map_first_id_proof (p : Pair T1 T2) : p.map_first id = p := by
  cases p; rfl

theorem map_second_id_proof (p : Pair T1 T2) : p.map_second id = p := by
  cases p; rfl

theorem tuple_size_proof (p : Pair T1 T2) : p.tuple_size = 2 := by rfl

end Cpp.Pair
