import Lean

open Lean in
macro "Wrap " n:ident " := " e:term : command => do
  `(noncomputable def $n := $e)

open Lean Elab Command in
elab "Signature " n:ident " : " t:term : command => do
  let name := n.getId
  let env ← getEnv
  match env.find? name with
  | some (.defnInfo val) =>
    if val.safety != .safe then
      throwError s!"{name} is partial/unsafe — use PartialSignature instead"
  | some (.opaqueInfo _) =>
    throwError s!"{name} is partial — use PartialSignature instead"
  | some _ => throwError s!"{name} is not a function definition"
  | none   => throwError s!"{name} not found in environment"
  elabCommand (← `(section variable (_sig_check : $t := $(n)) end))

open Lean Elab Command in
elab "PartialSignature " n:ident " : " t:term : command => do
  let name := n.getId
  let env ← getEnv
  match env.find? name with
  | some (.defnInfo val) =>
    if val.safety == .safe then
      throwError s!"{name} is total — use Signature instead"
  | some (.opaqueInfo _) => pure ()
  | some _ => throwError s!"{name} is not a function definition"
  | none   => throwError s!"{name} not found in environment"
  elabCommand (← `(section variable (_sig_check : $t := $(n)) end))

open Lean in
macro "ProvenTheorem " n:ident " : " t:term : command => do
  let proofName := Lean.mkIdent (n.getId.appendAfter "_proof")
  `(theorem $n : $t := $proofName)

open Lean in
macro "TestedConjecture " n:ident " : " t:term : command => do
  let testName := Lean.mkIdent (n.getId.appendAfter "_test")
  `(set_option linter.unusedVariables false in
    noncomputable def _tc_check := $testName
    theorem $n : $t := by sorry)

macro "UnprovenConjecture " n:ident " : " t:term : command =>
  `(theorem $n : $t := by sorry)

open Lean Elab Command in
syntax "DerivedConjecture " ident " : " term " assuming " sepBy1(ident, ", ") : command

open Lean Elab Command in
elab_rules : command
  | `(DerivedConjecture $n : $t assuming $[$deps],*) => do
    -- Check each dependency exists in the environment
    for dep in deps do
      let depName := dep.getId
      let env ← getEnv
      match env.find? depName with
      | some _ => pure ()
      | none =>
        -- Try with current namespace prefix
        let ns ← getCurrNamespace
        let fullName := ns ++ depName
        let env ← getEnv
        match env.find? fullName with
        | some _ => pure ()
        | none => throwError s!"DerivedConjecture dependency '{depName}' not found in environment"
    -- Check the derivation exists
    let derivationName := Lean.mkIdent (n.getId.appendAfter "_derivation")
    elabCommand (← `(
      set_option linter.unusedVariables false in
      noncomputable def _dc_check := $derivationName))
    -- The theorem itself is sorry (the assumptions aren't all proven yet)
    elabCommand (← `(theorem $n : $t := by sorry))

macro "FastHeader " n:ident " : " t:term : command =>
  `(axiom $n : $t)
