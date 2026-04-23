# Cslib.Computability.Languages.RegularLanguage

## Summary
Proves closure properties of regular languages: complementation, empty, singleton, universal, intersection, union, finite intersection/union, concatenation, Kleene star, and congruence class regularity. Provides characterizations of regularity via DFA and NFA.

## Vocabulary
| Name | Kind | Description |
|------|------|-------------|
| `Language.IsRegular` | (from Mathlib) | A language is regular |

## Theorems

| # | Name | Signature | Visibility |
|---|------|-----------|------------|
| 1 | `IsRegular.iff_dfa` | `{l : Language Symbol} : l.IsRegular ↔ ∃ State : Type, ∃ _ : Finite State, ∃ dfa : DA.FinAcc State Symbol, language dfa = l` | PUBLIC |
| 2 | `IsRegular.iff_nfa` | `{l : Language Symbol} : l.IsRegular ↔ ∃ State : Type, ∃ _ : Finite State, ∃ nfa : NA.FinAcc State Symbol, language nfa = l` | PUBLIC |
| 3 | `IsRegular.compl` | `{l : Language Symbol} (h : l.IsRegular) : (lᶜ).IsRegular` | PUBLIC |
| 4 | `IsRegular.zero` | `(0 : Language Symbol).IsRegular` | PUBLIC |
| 5 | `IsRegular.one` | `(1 : Language Symbol).IsRegular` | PUBLIC |
| 6 | `IsRegular.top` | `(⊤ : Language Symbol).IsRegular` | PUBLIC |
| 7 | `IsRegular.inf` | `(h1 : l1.IsRegular) (h2 : l2.IsRegular) : (l1 ⊓ l2).IsRegular` | PUBLIC |
| 8 | `IsRegular.add` | `(h1 : l1.IsRegular) (h2 : l2.IsRegular) : (l1 + l2).IsRegular` | PUBLIC |
| 9 | `IsRegular.iInf` | `{I : Type*} [Finite I] {s : Set I} {l : I → Language Symbol} (h : ∀ i ∈ s, (l i).IsRegular) : (⨅ i ∈ s, l i).IsRegular` | PUBLIC |
| 10 | `IsRegular.iSup` | `{I : Type*} [Finite I] {s : Set I} {l : I → Language Symbol} (h : ∀ i ∈ s, (l i).IsRegular) : (⨆ i ∈ s, l i).IsRegular` | PUBLIC |
| 11 | `IsRegular.mul` | `[Inhabited Symbol] (h1 : l1.IsRegular) (h2 : l2.IsRegular) : (l1 * l2).IsRegular` | PUBLIC |
| 12 | `IsRegular.kstar` | `[Inhabited Symbol] (h : l.IsRegular) : (l∗).IsRegular` | PUBLIC |
| 13 | `IsRegular.congr_fin_index` | `{Symbol : Type} [c : RightCongruence Symbol] [Finite (Quotient c.eq)] (a : Quotient c.eq) : (eqvCls a).IsRegular` | PUBLIC |

## Statistics
- Theorems/Lemmas: 13
- Lines of code: 188
- Imports: Cslib.Computability.Automata.DA.{Congr,Prod,ToNA}, Cslib.Computability.Automata.NA.{Concat,Loop,ToDA}, Mathlib.Computability.DFA, Mathlib.Data.{Finite.Sum, Set.Card}
