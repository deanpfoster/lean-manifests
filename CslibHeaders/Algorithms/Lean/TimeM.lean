import CslibHeaders.Basic
import Cslib.Algorithms.Lean.TimeM

/-! # TimeM: Time Complexity Monad

  `TimeM T α` pairs a return value with an accumulated cost.
  Used to prove both correctness (via `.ret`) and complexity (via `.time`).

  ## Vocabulary
  - `TimeM T α` — structure with `.ret : α` and `.time : T`
  - `⟪tm⟫` — notation for `tm.ret` (extract return value)
  - `✓` — tick macro, adds one unit of cost in a do block
-/

open Cslib.Algorithms.Lean
open Cslib.Algorithms.Lean.TimeM

ExternalTheorem ret_pure
  := @TimeM.ret_pure
  : ∀ {T : Type} {α : Type} [Zero T] (a : α), (pure a : TimeM T α).ret = a

ExternalTheorem ret_bind
  := @TimeM.ret_bind
  : ∀ {T : Type} {α β : Type} [Add T] (m : TimeM T α) (f : α → TimeM T β),
    (m >>= f).ret = (f m.ret).ret

ExternalTheorem time_bind
  := @TimeM.time_bind
  : ∀ {T : Type} {α β : Type} [Add T] (m : TimeM T α) (f : α → TimeM T β),
    (m >>= f).time = m.time + (f m.ret).time

ExternalTheorem time_pure
  := @TimeM.time_pure
  : ∀ {T : Type} {α : Type} [Zero T] (a : α), (pure a : TimeM T α).time = 0
