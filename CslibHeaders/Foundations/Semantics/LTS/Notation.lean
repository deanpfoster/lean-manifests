import CslibHeaders.Basic
import Cslib.Foundations.Semantics.LTS.Notation

/-! # LTS Notation: transition notation macros

  ## Vocabulary
  - `Cslib.LTS.Tr.toRelation lts μ` — the relation `fun s1 s2 => lts.Tr s1 μ s2`
  - `Cslib.LTS.MTr.toRelation lts μs` — the relation `fun s1 s2 => lts.MTr s1 μs s2`
  - `Cslib.LTS.Relation.toLTS r μ` — convert a relation to an LTS
  - `create_lts`, `lts_transition_notation`, `lts` attribute — notation infrastructure

  This module is meta-programming notation; no standalone theorems to export.
-/
