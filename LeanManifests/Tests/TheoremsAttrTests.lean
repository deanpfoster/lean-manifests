import LeanManifests.Basic

/-! # Tests for the @[theorems] attribute

  Verifies that the parametric attribute stores and retrieves theorem names.
-/

namespace TheoremsAttrTests

-- A simple function and its theorem
def myAdd (a b : Nat) : Nat := a + b

theorem myAdd_comm : ∀ a b, myAdd a b = myAdd b a := by
  intros; simp [myAdd, Nat.add_comm]

theorem myAdd_zero : ∀ a, myAdd a 0 = a := by
  intros; simp [myAdd]

-- Tag the function with its theorems
@[theorems myAdd_comm, myAdd_zero]
def myAdd' (a b : Nat) : Nat := a + b

-- Verify we can query the attribute at elaboration time
open Lean in
#eval show CoreM Unit from do
  let env ← getEnv
  let some thms := getTheorems? env ``myAdd' | throwError "no theorems found"
  unless thms.size == 2 do throwError s!"expected 2 theorems, got {thms.size}"
  unless thms[0]! == `myAdd_comm do throwError s!"first theorem mismatch: {thms[0]!}"
  unless thms[1]! == `myAdd_zero do throwError s!"second theorem mismatch: {thms[1]!}"
  IO.println s!"✓ @[theorems] attribute works: {thms.size} theorems stored"

end TheoremsAttrTests
