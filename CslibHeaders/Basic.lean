import Lean

/-! # Levelized Lean macros for CSLib headers -/

open Lean Elab Command in
/-- Full proof exists: looks for `foo_proof` or `foo_derivation`. -/
elab "ProvenTheorem " n:ident " : " t:term : command => do
  let name := n.getId
  let proofName := name.appendAfter "_proof"
  let derivationName := name.appendAfter "_derivation"
  let env ← getEnv
  let ns ← getCurrNamespace
  let hasProof := (env.find? (ns ++ proofName)).isSome || (env.find? proofName).isSome
  let hasDeriv := (env.find? (ns ++ derivationName)).isSome || (env.find? derivationName).isSome
  if hasProof then
    let rid := Lean.mkIdent proofName
    elabCommand (← `(theorem $n : $t := $rid))
  else if hasDeriv then
    let rid := Lean.mkIdent derivationName
    elabCommand (← `(theorem $n : $t := $rid))
  else
    throwError s!"ProvenTheorem {name}: neither '{proofName}' nor '{derivationName}' found"

/-- Reference an external theorem. Verifies it exists with the stated type. -/
macro "ExternalTheorem " n:ident " := " src:term " : " t:term : command =>
  `(set_option linter.unusedVariables false in
    noncomputable def $n : $t := $src)

/-- Light-weight check: verifies an existing theorem has the stated type. -/
macro "CheckTheorem " src:term " : " t:term : command =>
  `(set_option linter.unusedVariables false in
    noncomputable example : $t := $src)

-- Vocabulary: if name exists, verify; if not, define.
open Lean Elab Command in
elab "Vocabulary " n:ident " := " val:term : command => do
  let name := n.getId
  let ns ← getCurrNamespace
  let env ← getEnv
  let fullName := ns ++ name
  if (env.find? fullName).isSome || (env.find? name).isSome then
    elabCommand (← `(
      set_option linter.unusedVariables false in
      noncomputable example := ($val : _)))
  else
    elabCommand (← `(noncomputable def $n := $val))
