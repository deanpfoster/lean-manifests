import DeanLean.Manifests.LeanEnvironment
import Lean

/-! # Vocabulary for macro contracts (the specs) -/

open Lean LeanEnvironment

def ProvenTheoremSpec (env : Environment) (n : Name) (t : Expr) : Prop :=
  let proofName := n.appendAfter "_proof"
  let derivName := n.appendAfter "_derivation"
  ((env.find? proofName).isSome ∨ (env.find? derivName).isSome) →
  ∃ ci : ConstantInfo,
    match ci with
    | .thmInfo val => val.type = t ∧ ¬ ci.getUsedConstantsAsSet.contains ``sorryAx
    | _ => False

def TestedConjectureSpec (env : Environment) (n : Name) (t : Expr) : Prop :=
  let testName := n.appendAfter "_test"
  (env.find? testName).isSome →
  ∃ ci : ConstantInfo,
    match ci with
    | .thmInfo val => val.type = t ∧ ci.getUsedConstantsAsSet.contains ``sorryAx
    | _ => False

def SignatureSpec (envBefore envAfter : Environment) (n : Name) (t : Expr) : Prop :=
  match envBefore.find? n with
  | some ci => ci.type = t
  | none =>
    match envAfter.find? n with
    | some (.axiomInfo val) => val.type = t
    | _ => False

def EvidenceOrderingInvariant (env : Environment) : Prop :=
  (∀ (n : Name),
    (env.find? (n.appendAfter "_proof")).isSome →
    match env.find? n with
    | some ci => SorryFree ci
    | none => True) ∧
  (∀ (n : Name),
    (env.find? (n.appendAfter "_test")).isSome →
    match env.find? n with
    | some ci => UsesSorry ci
    | none => True)
