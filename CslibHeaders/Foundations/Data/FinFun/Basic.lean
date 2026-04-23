import CslibHeaders.Basic
import Cslib.Foundations.Data.FinFun.Basic

/-! # FinFun: finite-support functions

  ## Vocabulary
  - `Cslib.FinFun α β` (notation `α →₀ β`) — function with finite support
  - `FinFun.fromFun f support` (notation `f ↾₀ support`) — restrict a function to a support
  - `FinFun.fn` — the underlying function
  - `FinFun.support` — the finite support
-/

open Cslib Cslib.FinFun

ExternalTheorem finFun_ext
  := @Cslib.FinFun.ext
  : ∀ {β : Type u_1} {α : Type u_2} [inst : Zero β] {f g : α →₀ β},
    (∀ a, f a = g a) → f = g

ExternalTheorem finFun_mem_support_not_zero
  := @Cslib.FinFun.mem_support_not_zero
  : ∀ {β : Type u_1} {α : Type u_2} {a : α} [inst : Zero β] {f : α →₀ β},
    a ∈ f.support ↔ f a ≠ 0

ExternalTheorem finFun_not_mem_support_zero
  := @Cslib.FinFun.not_mem_support_zero
  : ∀ {β : Type u_1} {α : Type u_2} {a : α} [inst : Zero β] {f : α →₀ β},
    a ∉ f.support ↔ f a = 0

ExternalTheorem finFun_fromFun_idem
  := @Cslib.FinFun.fromFun_idem
  : ∀ {β : Type u_1} {α : Type u_2} [inst : Zero β] [inst_1 : DecidableEq α]
    [inst_2 : ∀ y : β, Decidable (y = 0)] {f : α → β} {support : Finset α},
    (f ↾₀ support) ↾₀ support = f ↾₀ support

ExternalTheorem finFun_coe_fromFun_id
  := @Cslib.FinFun.coe_fromFun_id
  : ∀ {β : Type u_1} {α : Type u_2} [inst : Zero β] [inst_1 : DecidableEq α]
    [inst_2 : ∀ y : β, Decidable (y = 0)] {f : α →₀ β},
    (f ↾₀ f.support) = f

ExternalTheorem finFun_fromFun_comm
  := @Cslib.FinFun.fromFun_comm
  : ∀ {β : Type u_1} {α : Type u_2} [inst : Zero β] [inst_1 : DecidableEq α]
    [inst_2 : ∀ y : β, Decidable (y = 0)] {f : α → β} {support1 support2 : Finset α},
    (f ↾₀ support1) ↾₀ support2 = (f ↾₀ support2) ↾₀ support1
