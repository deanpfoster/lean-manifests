import CslibHeaders.Basic
import Cslib.Foundations.Semantics.LTS.LTSCat.Basic

/-! # Category of Labelled Transition Systems

  ## Vocabulary
  - `Cslib.LTSCat` — bundled LTS (State, Label, and transition relation)
  - `Cslib.LTS.Morphism lts₁ lts₂` — morphism between two LTSs
  - `LTS.withIdle lts` — extend an LTS with idle (identity) transitions

  LTSs and their morphisms form a `CategoryTheory.Category`.
  This module is primarily definitions and instances; no standalone theorems to export.
-/
