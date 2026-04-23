import CslibHeaders.Basic
import Cslib.Foundations.Control.Monad.Free.Fold

/-! # Free Monad Catamorphism (Fold)

  ## Vocabulary
  - `FreeM.foldFreeM onValue onEffect` — the unique algebra morphism from `FreeM F α`
  - `FreeM.foldFreeM_unique` — universal property: any compatible `h` equals `foldFreeM`
-/

open Cslib Cslib.FreeM

universe u v w w'

ExternalTheorem foldFreeM_unique
  := @Cslib.FreeM.foldFreeM_unique
  : ∀ {F : Type u → Type v} {α : Type w} {β : Type w'}
    (onValue : α → β)
    (onEffect : {ι : Type u} → F ι → (ι → β) → β)
    (h : FreeM F α → β)
    (h_pure : ∀ a, h (.pure a) = onValue a)
    (h_liftBind : ∀ {ι} (op : F ι) (k : ι → FreeM F α),
      h (.liftBind op k) = onEffect op (fun x => h (k x))),
    h = FreeM.foldFreeM onValue onEffect
