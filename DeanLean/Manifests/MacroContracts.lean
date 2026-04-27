import DeanLean.Basic
import DeanLean.Defs.Manifests.MacroContracts
import DeanLean.Proofs.Manifests.MacroContracts

/-! # Macro Contracts — what our manifest system guarantees

  Vocabulary (specs) in Defs/Manifests/MacroContracts.lean.
  Derivations in Proofs/Manifests/MacroContracts.lean.
  This file: just the DerivedConjectures.
-/

open Lean LeanEnvironment

DerivedConjecture ProvenTheorem_is_correct :
    ∀ (env : Environment) (n : Name) (t : Expr),
    ProvenTheoremSpec env n t

DerivedConjecture TestedConjecture_is_correct :
    ∀ (env : Environment) (n : Name) (t : Expr),
    TestedConjectureSpec env n t

DerivedConjecture evidence_levels_are_distinguishable :
    ∀ (env : Environment), EvidenceOrderingInvariant env
