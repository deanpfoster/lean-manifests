import CslibHeaders.Basic
import Cslib.Foundations.Control.Monad.Free

/-! # Free Monad (Freer Monad)

  ## Vocabulary
  - `Cslib.FreeM F α` — free monad over type constructor `F`
  - `FreeM.pure` — return a value
  - `FreeM.liftBind` — invoke an operation with a continuation
  - `FreeM.lift` — lift a single operation into the free monad
  - `FreeM.liftM` — canonical interpreter (universal property)
  - `FreeM.Interprets` — predicate: an interpreter extends an effect handler
-/

open Cslib Cslib.FreeM

universe u v w

-- ════════════════════════════════════════════
-- Monad laws verified externally
-- ════════════════════════════════════════════

ExternalTheorem freeM_bind_assoc
  := @Cslib.FreeM.bind_assoc
  : ∀ {F : Type u → Type v} {α : Type w} {β : Type u_1} {γ : Type u_2}
    (x : FreeM F α) (f : α → FreeM F β) (g : β → FreeM F γ),
    (x.bind f).bind g = x.bind (fun x => (f x).bind g)

-- ════════════════════════════════════════════
-- Universal property of the free monad
-- ════════════════════════════════════════════

ExternalTheorem interprets_eq
  := @Cslib.FreeM.Interprets.eq
  : ∀ {F : Type u → Type v} {m : Type u → Type w} [inst : Monad m] {α : Type u}
    {handler : {ι : Type u} → F ι → m ι} {interp : FreeM F α → m α},
    FreeM.Interprets handler interp → interp = (·.liftM @handler)

ExternalTheorem interprets_iff
  := @Cslib.FreeM.Interprets.iff
  : ∀ {F : Type u → Type v} {m : Type u → Type w} [inst : Monad m] {α : Type u}
    (handler : {ι : Type u} → F ι → m ι) (interp : FreeM F α → m α),
    FreeM.Interprets handler interp ↔ interp = (·.liftM handler)

-- ════════════════════════════════════════════
-- liftM homomorphism laws
-- ════════════════════════════════════════════

ExternalTheorem freeM_liftM_lift
  := @Cslib.FreeM.liftM_lift
  : ∀ {F : Type u → Type v} {m : Type u → Type w} [inst : Monad m] {β : Type u}
    [inst_1 : LawfulMonad m] (interp : {ι : Type u} → F ι → m ι) (op : F β),
    (FreeM.lift op).liftM interp = interp op

ExternalTheorem freeM_liftM_bind
  := @Cslib.FreeM.liftM_bind
  : ∀ {F : Type u → Type v} {m : Type u → Type w} [inst : Monad m] {α β : Type u}
    [inst_1 : LawfulMonad m] (interp : {ι : Type u} → F ι → m ι)
    (x : FreeM F α) (f : α → FreeM F β),
    (x.bind f).liftM interp = (do let a ← x.liftM interp; (f a).liftM interp)
