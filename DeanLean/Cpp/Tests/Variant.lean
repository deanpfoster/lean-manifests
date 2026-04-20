import DeanLean.Cpp.Code.Variant

namespace Cpp.Variant2.Tests

-- Variant2: construct and query index
#eval do
  let v : Cpp.Variant2 Nat String := Cpp.Variant2.first 42
  assert! v.index.val == 0
  assert! v.holds_alternative (Fin.mk 0 (by omega)) == true
  assert! v.holds_alternative (Fin.mk 1 (by omega)) == false
  assert! v.valueless_by_exception == false
  assert! v.variant_size == 2

#eval do
  let v : Cpp.Variant2 Nat String := Cpp.Variant2.second "hello"
  assert! v.index.val == 1
  assert! v.holds_alternative (Fin.mk 1 (by omega)) == true
  assert! v.holds_alternative (Fin.mk 0 (by omega)) == false

-- Variant2: visit
#eval do
  let v1 : Cpp.Variant2 Nat String := Cpp.Variant2.first 10
  let v2 : Cpp.Variant2 Nat String := Cpp.Variant2.second "abc"
  assert! v1.visit toString id == "10"
  assert! v2.visit toString id == "abc"

-- Variant2: visit with uniform result type
#eval do
  let v1 : Cpp.Variant2 Nat String := Cpp.Variant2.first 10
  let v2 : Cpp.Variant2 Nat String := Cpp.Variant2.second "abc"
  assert! v1.visit (fun n => n * 2) (fun (s : String) => s.length) == 20
  assert! v2.visit (fun n => n * 2) (fun (s : String) => s.length) == 3

-- Variant2: get with proof
#eval do
  let v : Cpp.Variant2 Nat String := Cpp.Variant2.first 99
  let h : v.index = Fin.mk 0 (by omega) := rfl
  assert! v.get_first h == 99

#eval do
  let v : Cpp.Variant2 Nat String := Cpp.Variant2.second "world"
  let h : v.index = Fin.mk 1 (by omega) := rfl
  assert! v.get_second h == "world"

-- Variant2: BEq
#eval do
  let v1 : Cpp.Variant2 Nat String := Cpp.Variant2.first 42
  let v2 : Cpp.Variant2 Nat String := Cpp.Variant2.first 42
  let v3 : Cpp.Variant2 Nat String := Cpp.Variant2.first 99
  let v4 : Cpp.Variant2 Nat String := Cpp.Variant2.second "hi"
  assert! v1 == v2
  assert! !(v1 == v3)
  assert! !(v1 == v4)

end Cpp.Variant2.Tests

namespace Cpp.Variant3.Tests

-- Variant3: construct and query index
#eval do
  let v : Cpp.Variant3 Nat String Bool := Cpp.Variant3.first 42
  assert! v.index.val == 0
  assert! v.holds_alternative (Fin.mk 0 (by omega)) == true
  assert! v.valueless_by_exception == false
  assert! v.variant_size == 3

#eval do
  let v : Cpp.Variant3 Nat String Bool := Cpp.Variant3.second "hello"
  assert! v.index.val == 1

#eval do
  let v : Cpp.Variant3 Nat String Bool := Cpp.Variant3.third true
  assert! v.index.val == 2
  assert! v.holds_alternative (Fin.mk 2 (by omega)) == true

-- Variant3: visit
#eval do
  let v1 : Cpp.Variant3 Nat String Bool := Cpp.Variant3.first 10
  let v2 : Cpp.Variant3 Nat String Bool := Cpp.Variant3.second "abc"
  let v3 : Cpp.Variant3 Nat String Bool := Cpp.Variant3.third false
  let toStr := fun (v : Cpp.Variant3 Nat String Bool) =>
    v.visit toString id (fun b => if b then "yes" else "no")
  assert! toStr v1 == "10"
  assert! toStr v2 == "abc"
  assert! toStr v3 == "no"

-- Variant3: get with proof
#eval do
  let v : Cpp.Variant3 Nat String Bool := Cpp.Variant3.third true
  let h : v.index = Fin.mk 2 (by omega) := rfl
  assert! v.get_third h == true

end Cpp.Variant3.Tests
