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

open Lean in
macro "DerivedConjecture " n:ident " : " t:term : command => do
  let derivationName := Lean.mkIdent (n.getId.appendAfter "_derivation")
  `(set_option linter.unusedVariables false in
    noncomputable def _dc_check := $derivationName
    theorem $n : $t := by sorry)

macro "FastHeader " n:ident " : " t:term : command =>
  `(axiom $n : $t)
