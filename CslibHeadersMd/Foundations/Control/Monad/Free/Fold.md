# Cslib.Foundations.Control.Monad.Free.Fold

## Module Summary

Defines the fold (catamorphism) for free monads and proves its universal property: `foldFreeM` is the unique algebra morphism from the initial algebra `FreeM F alpha` to any target algebra.

## Vocabulary

None beyond `FreeM` (imported).

## Theorems

### PUBLIC

| # | Name | Signature |
|---|------|-----------|
| 1 | `foldFreeM_pure` | `theorem foldFreeM_pure (onValue : α → β) (onEffect : {ι : Type u} → F ι → (ι → β) → β) (a : α) : foldFreeM onValue onEffect (.pure a) = onValue a` |
| 2 | `foldFreeM_liftBind` | `theorem foldFreeM_liftBind (onValue : α → β) (onEffect : {ι : Type u} → F ι → (ι → β) → β) (op : F ι) (k : ι → FreeM F α) : foldFreeM onValue onEffect (.liftBind op k) = onEffect op (fun x => foldFreeM onValue onEffect (k x))` |
| 3 | `foldFreeM_unique` | `theorem foldFreeM_unique (onValue : α → β) (onEffect : {ι : Type u} → F ι → (ι → β) → β) (h : FreeM F α → β) (h_pure : ∀ a, h (.pure a) = onValue a) (h_liftBind : ∀ {ι} (op : F ι) (k : ι → FreeM F α), h (.liftBind op k) = onEffect op (fun x => h (k x))) : h = foldFreeM onValue onEffect` |

### INTERNAL

None.

## Counts

- **PUBLIC**: 3
- **INTERNAL**: 0
