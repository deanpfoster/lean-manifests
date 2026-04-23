import CslibHeaders.Basic
import Cslib.Foundations.Data.BiTape

/-! # BiTape: Bidirectionally infinite TM tape using StackTape

  ## Vocabulary
  - `Turing.BiTape Symbol` — tape with head, left StackTape, right StackTape
  - `BiTape.nil` — the empty tape
  - `BiTape.mk₁` — construct tape from a list of symbols
  - `BiTape.move` — move head left or right
  - `BiTape.write` — write a symbol at head position
  - `BiTape.space_used` — number of cells used
-/

open Turing Turing.BiTape

-- ════════════════════════════════════════════
-- Movement inverses
-- ════════════════════════════════════════════

ExternalTheorem move_left_move_right
  := @Turing.BiTape.move_left_move_right
  : ∀ {Symbol : Type} (t : BiTape Symbol), t.move_left.move_right = t

ExternalTheorem move_right_move_left
  := @Turing.BiTape.move_right_move_left
  : ∀ {Symbol : Type} (t : BiTape Symbol), t.move_right.move_left = t

-- ════════════════════════════════════════════
-- Space usage
-- ════════════════════════════════════════════

ExternalTheorem space_used_write
  := @Turing.BiTape.space_used_write
  : ∀ {Symbol : Type} (t : BiTape Symbol) (a : Option Symbol),
    (t.write a).space_used = t.space_used

ExternalTheorem space_used_mk₁
  := @Turing.BiTape.space_used_mk₁
  : ∀ {Symbol : Type} (l : List Symbol),
    (BiTape.mk₁ l).space_used = max 1 l.length

ExternalTheorem space_used_move
  := @Turing.BiTape.space_used_move
  : ∀ {Symbol : Type} (t : BiTape Symbol) (d : Turing.Dir),
    (t.move d).space_used ≤ t.space_used + 1
