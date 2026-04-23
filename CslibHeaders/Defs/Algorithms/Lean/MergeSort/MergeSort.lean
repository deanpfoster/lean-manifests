import CslibHeaders.Basic
import Cslib.Algorithms.Lean.MergeSort.MergeSort

/-! # Vocabulary for MergeSort

  These definitions appear in theorem types.
  Currently re-exported from CSLib. If CSLib is replaced,
  these become standalone definitions — the header doesn't change.
-/

open Cslib.Algorithms.Lean Cslib.Algorithms.Lean.TimeM

-- The complexity monad
Vocabulary TimeM := @TimeM

-- The algorithms
Vocabulary merge := @merge
Vocabulary mergeSort := @mergeSort

-- Predicates
Vocabulary IsSorted := @IsSorted
