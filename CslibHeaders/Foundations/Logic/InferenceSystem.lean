import CslibHeaders.Basic
import Cslib.Foundations.Logic.InferenceSystem

/-! # InferenceSystem: notation typeclass for derivations

  ## Vocabulary
  - `Cslib.Logic.InferenceSystem α` — class with notation `⇓a` for derivations
  - `InferenceSystem.Derivable a` — `a` is derivable (existential wrapper)
  - `InferenceSystem.rwConclusion` — rewrite the conclusion of a derivation

  This module defines a notation typeclass; no public theorems beyond the class API.
-/
