import CslibHeaders.Basic
import Cslib.Foundations.Data.OmegaSequence.Flatten

/-! # OmegaSequence.Flatten: flattening an infinite sequence of lists

  ## Vocabulary
  - `ωSequence.cumLen ls` — cumulative sum of list lengths
  - `ωSequence.flatten ls` — concatenation of all lists in `ls`
  - `ωSequence.toSegs s f` — segment `s` by a strictly monotonic `f`
-/

open Cslib Cslib.ωSequence

-- ════════════════════════════════════════════
-- Flatten
-- ════════════════════════════════════════════

ExternalTheorem ωSequence_cons_flatten
  := @Cslib.ωSequence.cons_flatten
  : ∀ {α : Type u_1} [inst : Inhabited α] {ls : ωSequence (List α)},
    (∀ k, (ls k).length > 0) →
    ls.head ++ω ls.tail.flatten = ls.flatten

ExternalTheorem ωSequence_extract_flatten
  := @Cslib.ωSequence.extract_flatten
  : ∀ {α : Type u_1} [inst : Inhabited α] {ls : ωSequence (List α)},
    (∀ k, (ls k).length > 0) →
    ∀ n, ls.flatten.extract (ls.cumLen n) (ls.cumLen (n + 1)) = ls n

-- ════════════════════════════════════════════
-- Segmentation round-trips
-- ════════════════════════════════════════════

ExternalTheorem ωSequence_strictMono_flatten
  := @Cslib.ωSequence.strictMono_flatten
  : ∀ {α : Type u_1} [inst : Inhabited α] {f : ℕ → ℕ},
    StrictMono f → f 0 = 0 →
    ∀ (s : ωSequence α), (s.toSegs f).flatten = s
