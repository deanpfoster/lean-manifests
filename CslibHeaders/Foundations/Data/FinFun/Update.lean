import CslibHeaders.Basic
import Cslib.Foundations.Data.FinFun.Update

/-! # FinFun.update: update operation for finite functions

  ## Vocabulary
  - `FinFun.update f a b` — update `f` at key `a` to value `b`
-/

open Cslib Cslib.FinFun

ExternalTheorem finFun_update_idem
  := @Cslib.FinFun.update_idem
  : ∀ {β : Type u_2} {α : Type u_1} [inst : Zero β] [inst_1 : DecidableEq α]
    [inst_2 : DecidableEqZero β] {a : α} {b b' : β}
    (f : α →₀ β), (f.update a b).update a b' = f.update a b'

ExternalTheorem finFun_update_comm
  := @Cslib.FinFun.update_comm
  : ∀ {β : Type u_2} {α : Type u_1} [inst : Zero β] [inst_1 : DecidableEq α]
    [inst_2 : DecidableEqZero β] {a a' : α} {b b' : β}
    (f : α →₀ β), a ≠ a' →
    (f.update a b).update a' b' = (f.update a' b').update a b

ExternalTheorem finFun_update_self
  := @Cslib.FinFun.update_self
  : ∀ {β : Type u_2} {α : Type u_1} [inst : Zero β] [inst_1 : DecidableEq α]
    [inst_2 : DecidableEqZero β] {a : α}
    (f : α →₀ β), f.update a (f a) = f
