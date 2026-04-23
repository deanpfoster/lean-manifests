# Cslib.Computability.Languages.Language

## Summary
Extends Mathlib's `Language` with additional definitions and theorems including bounded inf/sup membership, subtraction from 1, Kleene star decompositions, and algebraic identities for language operations.

## Vocabulary
| Name | Kind | Description |
|------|------|-------------|
| `Language` | (from Mathlib) | Set of finite words (lists) over an alphabet |

## Theorems

| # | Name | Signature | Visibility |
|---|------|-----------|------------|
| 1 | `mem_biInf` | `{I : Type*} (s : Set I) (l : I → Language α) (x : List α) : (x ∈ ⨅ i ∈ s, l i) ↔ ∀ i ∈ s, x ∈ l i` | PUBLIC |
| 2 | `mem_biSup` | `{I : Type*} (s : Set I) (l : I → Language α) (x : List α) : (x ∈ ⨆ i ∈ s, l i) ↔ ∃ i ∈ s, x ∈ l i` | PUBLIC |
| 3 | `le_one_iff_eq` | `l ≤ 1 ↔ l = 0 ∨ l = 1` | PUBLIC |
| 4 | `mem_sub_one` | `(x : List α) : x ∈ (l - 1) ↔ x ∈ l ∧ x ≠ []` | PUBLIC |
| 5 | `reverse_sub` | `(l m : Language α) : (l - m).reverse = l.reverse - m.reverse` | PUBLIC |
| 6 | `sub_one_mul` | `(l - 1) * l = l * l - 1` | PUBLIC |
| 7 | `mul_sub_one` | `l * (l - 1) = l * l - 1` | PUBLIC |
| 8 | `kstar_sub_one` | `l∗ - 1 = (l - 1) * l∗` | PUBLIC |
| 9 | `sub_one_kstar` | `(l - 1)∗ = l∗` | PUBLIC |
| 10 | `kstar_iff_mul_add` | `m = l∗ ↔ m = (l - 1) * m + 1` | PUBLIC |

## Statistics
- Theorems/Lemmas: 10
- Lines of code: 106
- Imports: Cslib.Init, Mathlib.Computability.Language
