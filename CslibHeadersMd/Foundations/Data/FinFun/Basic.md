# Cslib.Foundations.Data.FinFun.Basic

## Module Summary

Defines `FinFun`, a computable finite-support function type (similar to `Finsupp` but computable). Provides construction, extensional equality, restriction (`fromFun`), and decidable equality.

## Vocabulary

| Name | Kind | Description |
|------|------|-------------|
| `FinFun` | structure | Function `fn : α → β` with finite `support : Finset α` and proof `mem_support_fn` |
| `FinFun.fromFun` | def | Restrict a function to a given support, filtering out zero-mapped elements |

## Theorems

### PUBLIC

| # | Name | Signature |
|---|------|-----------|
| 1 | `coe_fn` | `theorem coe_fn [Zero β] {f : α →₀ β} : (f : α → β) = f.fn` |
| 2 | `coe_eq_fn` | `theorem coe_eq_fn [Zero β] {f : α →₀ β} : f a = f.fn a` |
| 3 | `ext` | `theorem ext [Zero β] {f g : α →₀ β} (h : ∀ (a : α), f a = g a) : f = g` |
| 4 | `mem_support_not_zero` | `theorem mem_support_not_zero [Zero β] {f : α →₀ β} : a ∈ f.support ↔ f a ≠ 0` |
| 5 | `not_mem_support_zero` | `theorem not_mem_support_zero [Zero β] {f : α →₀ β} : a ∉ f.support ↔ f a = 0` |
| 6 | `eq_fields_eq` | `theorem eq_fields_eq [Zero β] {f g : α →₀ β} : f = g → f.fn = g.fn ∧ f.support = g.support` |
| 7 | `fn_eq_eq` | `theorem fn_eq_eq [Zero β] {f g : α →₀ β} (h : f.fn = g.fn) : f = g` |
| 8 | `congrFinFun` | `theorem congrFinFun [Zero β] {f g : α →₀ β} (h : f = g) (a : α) : f a = g a` |
| 9 | `fromFun_eq` | `theorem fromFun_eq [Zero β] [DecidableEq α] [∀ y : β, Decidable (y = 0)] (f : α → β) (support : Finset α) (h : ∀ a, a ∉ support → f a = 0) : (f ↾₀ support) = f` |
| 10 | `fromFun_fn` | `theorem fromFun_fn [Zero β] [DecidableEq α] [∀ y : β, Decidable (y = 0)] (f : α → β) (support : Finset α) : (f ↾₀ support).fn = (fun a => if a ∈ support then f a else 0)` |
| 11 | `fromFun_support` | `theorem fromFun_support [Zero β] [DecidableEq α] [∀ y : β, Decidable (y = 0)] (f : α → β) (support : Finset α) : (f ↾₀ support).support = support.filter (f · ≠ 0)` |
| 12 | `fromFun_idem` | `theorem fromFun_idem [Zero β] [DecidableEq α] [∀ y : β, Decidable (y = 0)] {f : α → β} {support : Finset α} : (f ↾₀ support) ↾₀ support = f ↾₀ support` |
| 13 | `coe_fromFun_id` | `theorem coe_fromFun_id [Zero β] [DecidableEq α] [∀ y : β, Decidable (y = 0)] {f : α →₀ β} : (f ↾₀ f.support) = f` |
| 14 | `fromFun_inter` | `theorem fromFun_inter [Zero β] [DecidableEq α] [∀ y : β, Decidable (y = 0)] {f : α → β} {support1 support2 : Finset α} : (f ↾₀ support1) ↾₀ support2 = f ↾₀ (support1 ∩ support2)` |
| 15 | `fromFun_comm` | `theorem fromFun_comm [Zero β] [DecidableEq α] [∀ y : β, Decidable (y = 0)] {f : α → β} {support1 support2 : Finset α} : (f ↾₀ support1) ↾₀ support2 = (f ↾₀ support2) ↾₀ support1` |

### INTERNAL

None.

## Counts

- **PUBLIC**: 15
- **INTERNAL**: 0
