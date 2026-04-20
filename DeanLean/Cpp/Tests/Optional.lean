import DeanLean.Cpp.Code.Optional

namespace Cpp.Optional.Tests

#eval do
  let o := Cpp.Optional.some 42
  assert! o.has_value == true
  assert! o.value == 42
  assert! o.value_or 0 == 42

#eval do
  let o : Cpp.Optional Nat := Cpp.Optional.nullopt
  assert! o.has_value == false
  assert! o.value_or 99 == 99

#eval do
  let o := Cpp.Optional.some 10
  let doubled := o.transform (· * 2)
  assert! doubled.has_value == true
  assert! doubled.value == 20

#eval do
  let o : Cpp.Optional Nat := Cpp.Optional.nullopt
  assert! (o.transform (· * 2)).has_value == false

#eval do
  let o := Cpp.Optional.some 5
  let result := o.and_then fun n =>
    if n > 3 then Cpp.Optional.some (n * 10) else Cpp.Optional.nullopt
  assert! result.value == 50

#eval do
  let o := Cpp.Optional.some 2
  let result := o.and_then fun n =>
    if n > 3 then Cpp.Optional.some (n * 10) else Cpp.Optional.nullopt
  assert! result.has_value == false

#eval do
  let o : Cpp.Optional Nat := Cpp.Optional.nullopt
  let result := o.or_else fun () => Cpp.Optional.some 42
  assert! result.value == 42

#eval do
  let o := Cpp.Optional.some 7
  let result := o.or_else fun () => Cpp.Optional.some 42
  assert! result.value == 7

#eval do
  let result := do
    let a ← Cpp.Optional.some 10
    let b ← Cpp.Optional.some 20
    pure (a + b)
  assert! result == Cpp.Optional.some 30

#eval do
  let result : Cpp.Optional Nat := do
    let a ← Cpp.Optional.some 10
    let _ ← (Cpp.Optional.nullopt : Cpp.Optional Nat)
    pure (a + 20)
  assert! result == Cpp.Optional.nullopt

end Cpp.Optional.Tests
