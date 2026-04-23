import CslibHeaders.Basic
import Cslib.Foundations.Semantics.LTS.Union

/-! # Union of LTSs

  ## Vocabulary
  - `Cslib.LTS.union lts1 lts2` — union of two LTSs on the same types
  - `Cslib.LTS.unionSubtype lts1 lts2` — union with common supertypes
  - `Cslib.LTS.unionSum lts1 lts2` — union combining state types via `Sum`
  - `Cslib.LTS.inl lts` — lift to left component of a sum
  - `Cslib.LTS.inr lts` — lift to right component of a sum

  This module defines constructions; no standalone theorems to export.
-/
