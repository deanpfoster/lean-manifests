# Cslib.Computability.Languages.OmegaLanguage

## Summary
Defines omega-languages (sets of infinite sequences) with a rich algebraic structure including concatenation with finite languages (hmul), omega-power, omega-limit, and map. Proves many algebraic identities and the key coinductive characterization of omega-power.

## Vocabulary
| Name | Kind | Description |
|------|------|-------------|
| `ωLanguage` | structure | Set of omega-sequences over an alphabet |
| `omegaPow` / `l^ω` | def | Omega-power: concatenation of infinitely many nonempty words from l |
| `omegaLim` / `l↗ω` | def | Omega-limit: sequences with infinitely many prefixes in l |
| `HMul Language ωLanguage ωLanguage` | instance | Concatenation of finite language and omega-language |
| `ωLanguage.map` | def | Map omega-language through a function |

## Theorems

| # | Name | Signature | Visibility |
|---|------|-----------|------------|
| 1 | `mem_def` | `(p : ωLanguage α) (s : ωSequence α) : s ∈ p ↔ s ∈ p.toSet` | PUBLIC |
| 2 | `mem_ext` | `(h : ∀ (s : ωSequence α), s ∈ p ↔ s ∈ q) : p = q` | PUBLIC |
| 3 | `mem_top` | `(s : ωSequence α) : s ∈ (⊤ : ωLanguage α)` | PUBLIC |
| 4 | `notMem_bot` | `(s : ωSequence α) : s ∉ (⊥ : ωLanguage α)` | PUBLIC |
| 5 | `mem_sup` | `(p q : ωLanguage α) (s : ωSequence α) : s ∈ p ⊔ q ↔ s ∈ p ∨ s ∈ q` | PUBLIC |
| 6 | `mem_inf` | `(p q : ωLanguage α) (s : ωSequence α) : s ∈ p ⊓ q ↔ s ∈ p ∧ s ∈ q` | PUBLIC |
| 7 | `mem_compl` | `(p : ωLanguage α) (s : ωSequence α) : s ∈ pᶜ ↔ ¬ s ∈ p` | PUBLIC |
| 8 | `mem_sSup` | `(ps : Set (ωLanguage α)) {s : ωSequence α} : s ∈ sSup ps ↔ ∃ p ∈ ps, s ∈ p` | PUBLIC |
| 9 | `mem_sInf` | `(ps : Set (ωLanguage α)) {s : ωSequence α} : s ∈ sInf ps ↔ ∀ p ∈ ps, s ∈ p` | PUBLIC |
| 10 | `mem_iSup` | `{ι : Sort v} {p : ι → ωLanguage α} {s : ωSequence α} : (s ∈ ⨆ i, p i) ↔ ∃ i, s ∈ p i` | PUBLIC |
| 11 | `mem_iInf` | `{ι : Sort v} {p : ι → ωLanguage α} {s : ωSequence α} : (s ∈ ⨅ i, p i) ↔ ∀ i, s ∈ p i` | PUBLIC |
| 12 | `mem_hmul` | `s ∈ l * p ↔ ∃ x ∈ l, ∃ t ∈ p, x ++ω t = s` | PUBLIC |
| 13 | `append_mem_hmul` | `x ∈ l → s ∈ p → x ++ω s ∈ l * p` | PUBLIC |
| 14 | `mem_omegaPow` | `[Inhabited α] : s ∈ l^ω ↔ ∃ xs : ωSequence (List α), xs.flatten = s ∧ ∀ k, xs k ∈ l - 1` | PUBLIC |
| 15 | `flatten_mem_omegaPow` | `[Inhabited α] (h_xs : ∀ k, xs k ∈ l - 1) : xs.flatten ∈ l^ω` | PUBLIC |
| 16 | `mem_omegaLim` | `s ∈ l↗ω ↔ ∃ᶠ m in atTop, s.extract 0 m ∈ l` | PUBLIC |
| 17 | `mul_hmul` | `(l * m) * p = l * (m * p)` | PUBLIC |
| 18 | `zero_hmul` | `(0 : Language α) * p = ⊥` | PUBLIC |
| 19 | `hmul_bot` | `l * (⊥ : ωLanguage α) = ⊥` | PUBLIC |
| 20 | `one_hmul` | `(1 : Language α) * p = p` | PUBLIC |
| 21 | `hmul_sup` | `l * (p ⊔ q) = l * p ⊔ l * q` | PUBLIC |
| 22 | `add_hmul` | `(l + m) * p = l * p ⊔ m * p` | PUBLIC |
| 23 | `iSup_hmul` | `{ι : Sort v} (l : ι → Language α) (p : ωLanguage α) : (⨆ i, l i) * p = ⨆ i, l i * p` | PUBLIC |
| 24 | `hmul_iSup` | `{ι : Sort v} (p : ι → ωLanguage α) (l : Language α) : (l * ⨆ i, p i) = ⨆ i, l * p i` | PUBLIC |
| 25 | `le_hmul_congr` | `(hl : l1 ≤ l2) (hp : p1 ≤ p2) : l1 * p1 ≤ l2 * p2` | PUBLIC |
| 26 | `le_omegaPow_congr` | `[Inhabited α] (h : l1 ≤ l2) : l1^ω ≤ l2^ω` | PUBLIC |
| 27 | `omegaPow_of_sub_one` | `[Inhabited α] : (l - 1)^ω = l^ω` | PUBLIC |
| 28 | `zero_omegaPow` | `[Inhabited α] : (0 : Language α)^ω = ⊥` | PUBLIC |
| 29 | `one_omegaPow` | `[Inhabited α] : (1 : Language α)^ω = ⊥` | PUBLIC |
| 30 | `omegaPow_of_le_one` | `[Inhabited α] (h : l ≤ 1) : l^ω = ⊥` | PUBLIC |
| 31 | `omegaPow_eq_empty` | `[Inhabited α] (h : l^ω = ⊥) : l ≤ 1` | PUBLIC |
| 32 | `hmul_seq_prop` | `l * p = { s : ωSequence α \| ∃ k, s.take k ∈ l ∧ s.drop k ∈ p }` | PUBLIC |
| 33 | `omegaPow_seq_prop` | `[Inhabited α] : l^ω = { s : ωSequence α \| ∃ f : ℕ → ℕ, StrictMono f ∧ f 0 = 0 ∧ ∀ m, s.extract (f m) (f (m + 1)) ∈ l }` | PUBLIC |
| 34 | `omegaPow_coind` | `[Inhabited α] (h_le : p ≤ (l - 1) * p) : p ≤ l^ω` | PUBLIC |
| 35 | `hmul_omegaPow_eq_omegaPow` | `[Inhabited α] (l : Language α) : l * l^ω = l^ω` | PUBLIC |
| 36 | `kstar_omegaPow_eq_omegaPow` | `[Inhabited α] (l : Language α) : (l∗)^ω = l^ω` | PUBLIC |
| 37 | `kstar_hmul_omegaPow_eq_omegaPow` | `[Inhabited α] (l : Language α) : l∗ * l^ω = l^ω` | PUBLIC |
| 38 | `omegaLim_zero` | `(0 : Language α)↗ω = ⊥` | PUBLIC |
| 39 | `map_id` | `(p : ωLanguage α) : map id p = p` | PUBLIC |
| 40 | `map_map` | `(g : β → γ) (f : α → β) (p : ωLanguage α) : map g (map f p) = map (g ∘ f) p` | PUBLIC |

## Statistics
- Theorems/Lemmas: 40
- Definitions/Structures: 5
- Instances: 5 (CompleteAtomicBooleanAlgebra, SetLike, HasSubset, HMul, OmegaPow, OmegaLim)
- Lines of code: 466
- Imports: Cslib.Computability.Languages.Language, Cslib.Foundations.Data.OmegaSequence.Flatten, Mathlib.Computability.Language, Mathlib.Order.CompleteBooleanAlgebra, Mathlib.Order.Filter.AtTopBot.Defs
