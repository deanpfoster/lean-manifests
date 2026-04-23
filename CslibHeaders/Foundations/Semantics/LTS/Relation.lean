import CslibHeaders.Basic
import Cslib.Foundations.Semantics.LTS.Relation

/-! # LTS-Relation conversions and calc support

  ## Vocabulary
  - `Cslib.LTS.Tr.toRelation lts μ` — fix a label to get a binary relation
  - `Cslib.LTS.MTr.toRelation lts μs` — fix a label list to get a binary relation
  - `Cslib.LTS.Relation.toLTS r μ` — turn a binary relation into an LTS
  - `Trans` instances for chaining Tr and MTr in `calc` blocks

  This module is primarily definitions and `Trans` instances; no standalone theorems.
-/
