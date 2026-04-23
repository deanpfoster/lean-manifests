import CslibHeaders.Basic
import Cslib.Foundations.Semantics.LTS.Termination

/-! # LTS Termination

  ## Vocabulary
  - `Cslib.LTS.MayTerminate lts Terminated s` — `s` can reach a terminated state
  - `Cslib.LTS.Stuck lts Terminated s` — `s` is neither terminated nor can transition

  This module defines predicates; no standalone theorems to export.
-/
