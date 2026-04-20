import DeanLean.Cpp.Code.Concepts

namespace Cpp.Concepts.Tests

-- ============================================================================
-- §18.4.7 Integral: test toInt on Nat and Int
-- ============================================================================

#eval do
  let n : Nat := 42
  let i : Int := -7
  assert! Integral.toInt n == 42
  assert! Integral.toInt i == -7

-- ============================================================================
-- §18.4.7 UnsignedIntegral: test toNat
-- ============================================================================

#eval do
  let n : Nat := 100
  assert! UnsignedIntegral.toNat n == 100

-- ============================================================================
-- §18.4.7 FloatingPoint: test toFloat
-- ============================================================================

#eval do
  let f : Float := 3.14
  assert! FloatingPoint.toFloat f == 3.14

-- ============================================================================
-- §18.4.4 ConvertibleTo: test Nat → Int conversion
-- ============================================================================

#eval do
  let n : Nat := 5
  let i : Int := ConvertibleTo.convert n
  assert! i == 5

-- ============================================================================
-- §18.7 Invocable: test function invocation
-- ============================================================================

#eval do
  let f : Nat → Nat := (· + 1)
  let result := Invocable.invoke f 41
  assert! result == 42

-- ============================================================================
-- §18.6 DefaultInitializable: test default values
-- ============================================================================

#eval do
  let n : Nat := DefaultInitializable.defaultValue
  assert! n == 0

-- ============================================================================
-- §18.4.2 same_as: test reflexivity at runtime
-- ============================================================================

#eval do
  -- same_as is a Prop (T = U), we can check that Nat = Nat
  let _ : same_as Nat Nat := rfl
  assert! true  -- the above line type-checks, confirming same_as Nat Nat

-- ============================================================================
-- §18.4.8 AssignableFrom: test assign
-- ============================================================================

-- Provide an instance for Nat
instance : AssignableFrom Nat Nat where
  assign := fun _ v => v

#eval do
  let x : Nat := 10
  let y : Nat := 20
  let result := AssignableFrom.assign x y
  assert! result == 20

-- ============================================================================
-- §18.5.4 EqualityComparable: test decidable equality
-- ============================================================================

#eval do
  let a : Nat := 42
  let b : Nat := 42
  let c : Nat := 7
  let eq_dec := EqualityComparable.eq_decidable (T := Nat)
  match eq_dec a b with
  | isTrue _  => assert! true
  | isFalse _ => assert! false
  match eq_dec a c with
  | isTrue _  => assert! false
  | isFalse _ => assert! true

end Cpp.Concepts.Tests
