# Cslib.Foundations.Data.FinFun.Update

## Module Summary

Defines the `update` operation for `FinFun` (the `FinFun` equivalent of `Function.update`) and proves its algebraic properties: idempotence, commutativity on distinct keys, self-update, and support bounds.

## Vocabulary

| Name | Kind | Description |
|------|------|-------------|
| `FinFun.update` | def | Update a `FinFun` at key `a` with value `b` |

## Theorems

### PUBLIC

| # | Name | Signature |
|---|------|-----------|
| 1 | `update_coe` | `theorem update_coe (f : α →₀ β) : (f.update a b : α → β) = Function.update f a b` |
| 2 | `update_apply` | `theorem update_apply (f : α →₀ β) : ((f.update a' b) a) = if a = a' then b else f a` |
| 3 | `update_support` | `theorem update_support (f : α →₀ β) : (f.update a b).support = if b = 0 then f.support \ {a} else f.support ∪ {a}` |
| 4 | `update_idem` | `theorem update_idem (f : α →₀ β) : (f.update a b).update a b' = f.update a b'` |
| 5 | `update_comm` | `theorem update_comm (f : α →₀ β) (h : a ≠ a') : (f.update a b).update a' b' = (f.update a' b').update a b` |
| 6 | `update_self` | `theorem update_self (f : α →₀ β) : (f.update a (f a)) = f` |
| 7 | `update_support_subseteq` | `theorem update_support_subseteq (f : α →₀ β) : (f.update a b).support ⊆ f.support ∪ {a}` |

### INTERNAL

None.

## Counts

- **PUBLIC**: 7
- **INTERNAL**: 0
