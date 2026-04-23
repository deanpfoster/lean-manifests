# Cslib.Foundations.Control.Monad.Free

## Module Summary

Defines the free monad `FreeM` over any type constructor `F` using the freer monad approach. Provides `Functor`, `Monad`, `LawfulFunctor`, `LawfulMonad` instances, the canonical interpreter `liftM`, and proves its universal property (`Interprets`).

## Vocabulary

| Name | Kind | Description |
|------|------|-------------|
| `FreeM` | inductive | Free monad over type constructor `F`, with `.pure` and `.liftBind` constructors |
| `FreeM.Interprets` | structure | Predicate: a function is an interpreter extending an effect handler |

## Theorems

### PUBLIC

| # | Name | Signature |
|---|------|-----------|
| 1 | `pure_eq_pure` | `theorem pure_eq_pure : (pure : α → FreeM F α) = FreeM.pure` |
| 2 | `FreeM.bind_assoc` | `theorem FreeM.bind_assoc (x : FreeM F α) (f : α → FreeM F β) (g : β → FreeM F γ) : (x.bind f).bind g = x.bind (fun x => (f x).bind g)` |
| 3 | `bind_eq_bind` | `theorem bind_eq_bind {α β : Type w} : Bind.bind = (FreeM.bind : FreeM F α → _ → FreeM F β)` |
| 4 | `id_map` | `theorem id_map : ∀ x : FreeM F α, map id x = x` |
| 5 | `comp_map` | `theorem comp_map (h : β → γ) (g : α → β) : ∀ x : FreeM F α, map (h ∘ g) x = map h (map g x)` |
| 6 | `map_eq_map` | `theorem map_eq_map {α β : Type w} : Functor.map = FreeM.map (F := F) (α := α) (β := β)` |
| 7 | `lift_def` | `lemma lift_def (op : F ι) : (lift op : FreeM F ι) = liftBind op .pure` |
| 8 | `map_lift` | `lemma map_lift (f : ι → α) (op : F ι) : map f (lift op : FreeM F ι) = liftBind op (fun z => (.pure (f z) : FreeM F α))` |
| 9 | `pure_bind` | `lemma pure_bind (a : α) (f : α → FreeM F β) : (.pure a : FreeM F α).bind f = f a` |
| 10 | `bind_pure` | `lemma bind_pure : ∀ x : FreeM F α, x.bind (.pure) = x` |
| 11 | `bind_pure_comp` | `lemma bind_pure_comp (f : α → β) : ∀ x : FreeM F α, x.bind (.pure ∘ f) = map f x` |
| 12 | `liftBind_bind` | `lemma liftBind_bind (op : F ι) (cont : ι → FreeM F α) (f : α → FreeM F β) : (liftBind op cont).bind f = liftBind op fun x => (cont x).bind f` |
| 13 | `liftM_pure` | `lemma liftM_pure (interp : {ι : Type u} → F ι → m ι) (a : α) : (.pure a : FreeM F α).liftM interp = pure a` |
| 14 | `liftM_liftBind` | `lemma liftM_liftBind (interp : {ι : Type u} → F ι → m ι) (op : F β) (cont : β → FreeM F α) : (liftBind op cont).liftM interp = (do let b ← interp op; (cont b).liftM interp)` |
| 15 | `liftM_lift` | `lemma liftM_lift [LawfulMonad m] (interp : {ι : Type u} → F ι → m ι) (op : F β) : (lift op).liftM interp = interp op` |
| 16 | `liftM_bind` | `lemma liftM_bind [LawfulMonad m] (interp : {ι : Type u} → F ι → m ι) (x : FreeM F α) (f : α → FreeM F β) : (x.bind f).liftM interp = (do let a ← x.liftM interp; (f a).liftM interp)` |
| 17 | `liftM_map` | `lemma liftM_map [LawfulMonad m] (interp : {ι : Type u} → F ι → m ι) (f : α → β) (x : FreeM F α) : (x.map f).liftM interp = f <$> x.liftM interp` |
| 18 | `liftM_seq` | `lemma liftM_seq [LawfulMonad m] (interp : {ι : Type u} → F ι → m ι) (x : FreeM F (α → β)) (y : FreeM F α) : (x <*> y).liftM interp = x.liftM interp <*> y.liftM interp` |
| 19 | `liftM_seqLeft` | `lemma liftM_seqLeft [LawfulMonad m] (interp : {ι : Type u} → F ι → m ι) (x : FreeM F α) (y : FreeM F β) : (x <* y).liftM interp = x.liftM interp <* y.liftM interp` |
| 20 | `liftM_seqRight` | `lemma liftM_seqRight [LawfulMonad m] (interp : {ι : Type u} → F ι → m ι) (x : FreeM F α) (y : FreeM F β) : (x *> y).liftM interp = x.liftM interp *> y.liftM interp` |
| 21 | `Interprets.eq` | `theorem Interprets.eq {handler : {ι : Type u} → F ι → m ι} {interp : FreeM F α → m α} (h : Interprets handler interp) : interp = (·.liftM @handler)` |
| 22 | `Interprets.liftM` | `theorem Interprets.liftM (handler : {ι : Type u} → F ι → m ι) : Interprets handler (·.liftM handler : FreeM F α → _)` |
| 23 | `Interprets.iff` | `theorem Interprets.iff (handler : {ι : Type u} → F ι → m ι) (interp : FreeM F α → m α) : Interprets handler interp ↔ interp = (·.liftM handler)` |

### INTERNAL

None.

## Counts

- **PUBLIC**: 23
- **INTERNAL**: 0
