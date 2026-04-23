import CslibHeaders.Basic
import Cslib.Foundations.Data.OmegaSequence.Defs

/-! # OmegaSequence: definition of infinite sequences

  ## Vocabulary
  - `Cslib.ωSequence α` — infinite sequence `ℕ → α` (wrapped)
  - `ωSequence.head` — first element
  - `ωSequence.tail` — drop the first element
  - `ωSequence.drop n` — drop the first `n` elements
  - `ωSequence.take n` — take the first `n` elements as a `List`
  - `ωSequence.cons a s` (notation `a ::ω s`) — prepend
  - `ωSequence.appendωSequence l s` (notation `l ++ω s`) — append list to sequence
  - `ωSequence.const a` — constant sequence
  - `ωSequence.map f s` — map a function over a sequence
  - `ωSequence.zip f s₁ s₂` — zip two sequences
  - `ωSequence.iterate f a` — iterates of `f` starting from `a`
  - `ωSequence.extract s m n` — extract elements from position `m` to `n-1`

  This module only defines the data type and basic operations; no theorems to export.
-/
