import CslibHeaders.Basic
import Cslib.Foundations.Data.StackTape

/-! # StackTape: infinite eventually-none lists

  ## Vocabulary
  - `Turing.StackTape Symbol` — list of `Option Symbol` that cannot end with `none`
  - `StackTape.nil` — the empty tape
  - `StackTape.cons` — prepend an option to the tape
  - `StackTape.head` — first element (or `none`)
  - `StackTape.tail` — tape without the first element
  - `StackTape.length` — number of elements up to last non-none
  - `StackTape.map_some` — create tape from a list by mapping to `some`
-/

open Turing Turing.StackTape

-- ════════════════════════════════════════════
-- Head / tail / cons laws
-- ════════════════════════════════════════════

ExternalTheorem stackTape_head_cons
  := @Turing.StackTape.head_cons
  : ∀ {Symbol : Type} (o : Option Symbol) (l : StackTape Symbol), (cons o l).head = o

ExternalTheorem stackTape_tail_cons
  := @Turing.StackTape.tail_cons
  : ∀ {Symbol : Type} (o : Option Symbol) (l : StackTape Symbol), (cons o l).tail = l

ExternalTheorem stackTape_cons_head_tail
  := @Turing.StackTape.cons_head_tail
  : ∀ {Symbol : Type} (l : StackTape Symbol), cons l.head l.tail = l

ExternalTheorem stackTape_eq_iff
  := @Turing.StackTape.eq_iff
  : ∀ {Symbol : Type} (l1 l2 : StackTape Symbol),
    l1 = l2 ↔ l1.head = l2.head ∧ l1.tail = l2.tail

-- ════════════════════════════════════════════
-- Length properties
-- ════════════════════════════════════════════

ExternalTheorem stackTape_length_cons_le
  := @Turing.StackTape.length_cons_le
  : ∀ {Symbol : Type} (o : Option Symbol) (l : StackTape Symbol),
    (cons o l).length ≤ l.length + 1

ExternalTheorem stackTape_length_tail_le
  := @Turing.StackTape.length_tail_le
  : ∀ {Symbol : Type} (l : StackTape Symbol), l.tail.length ≤ l.length
