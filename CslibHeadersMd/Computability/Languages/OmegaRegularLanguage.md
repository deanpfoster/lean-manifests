# Cslib.Computability.Languages.OmegaRegularLanguage

## Summary
Defines omega-regular languages as those accepted by finite-state nondeterministic Buchi automata. Proves closure under union, intersection, concatenation with regular languages, omega-power, complementation, and the decomposition into finite unions of L * M^omega. Contains the proof that DBA cannot accept all omega-regular languages and states McNaughton's theorem.

## Vocabulary
| Name | Kind | Description |
|------|------|-------------|
| `ωLanguage.IsRegular` | def | An omega-language is omega-regular iff accepted by a finite-state NBA |

## Theorems

| # | Name | Signature | Visibility |
|---|------|-----------|------------|
| 1 | `isRegular_iff` | `{p : ωLanguage Symbol} : p.IsRegular ↔ ∃ (σ : Type v) (_ : Finite σ) (na : NA.Buchi σ Symbol), language na = p` | PUBLIC |
| 2 | `IsRegular.of_da_buchi` | `{State : Type} [Finite State] (da : DA.Buchi State Symbol) : (language da).IsRegular` | PUBLIC |
| 3 | `IsRegular.not_da_buchi` | `∃ (Symbol : Type) (p : ωLanguage Symbol), p.IsRegular ∧ ¬ ∃ (State : Type) (da : DA.Buchi State Symbol), language da = p` | PUBLIC |
| 4 | `IsRegular.regular_omegaLim` | `{l : Language Symbol} (h : l.IsRegular) : (l↗ω).IsRegular` | PUBLIC |
| 5 | `IsRegular.bot` | `(⊥ : ωLanguage Symbol).IsRegular` | PUBLIC |
| 6 | `IsRegular.top` | `(⊤ : ωLanguage Symbol).IsRegular` | PUBLIC |
| 7 | `IsRegular.sup` | `(h1 : p1.IsRegular) (h2 : p2.IsRegular) : (p1 ⊔ p2).IsRegular` | PUBLIC |
| 8 | `IsRegular.inf` | `(h1 : p1.IsRegular) (h2 : p2.IsRegular) : (p1 ⊓ p2).IsRegular` | PUBLIC |
| 9 | `IsRegular.iSup` | `{I : Type*} [Finite I] {s : Set I} (h : ∀ i ∈ s, (p i).IsRegular) : (⨆ i ∈ s, p i).IsRegular` | PUBLIC |
| 10 | `IsRegular.iInf` | `{I : Type*} [Finite I] {s : Set I} (h : ∀ i ∈ s, (p i).IsRegular) : (⨅ i ∈ s, p i).IsRegular` | PUBLIC |
| 11 | `IsRegular.hmul` | `(h1 : l.IsRegular) (h2 : p.IsRegular) : (l * p).IsRegular` | PUBLIC |
| 12 | `IsRegular.omegaPow` | `[Inhabited Symbol] (h : l.IsRegular) : (l^ω).IsRegular` | PUBLIC |
| 13 | `IsRegular.eq_fin_iSup_hmul_omegaPow` | `[Inhabited Symbol] (p : ωLanguage Symbol) : p.IsRegular ↔ ∃ n : ℕ, ∃ l m : Fin n → Language Symbol, (∀ i, (l i).IsRegular ∧ (m i).IsRegular) ∧ p = ⨆ i, (l i) * (m i)^ω` | PUBLIC |
| 14 | `IsRegular.fin_cover_saturates` | `(hs : Saturates ...) (hc : ⨆ i, p i = ⊤) (hr : ∀ i, (p i).IsRegular) : q.IsRegular` | PUBLIC |
| 15 | `IsRegular.fin_cover_saturates_compl` | `(hs : Saturates ...) (hc : ⨆ i, p i = ⊤) (hr : ∀ i, (p i).IsRegular) : (qᶜ).IsRegular` | PUBLIC |
| 16 | `IsRegular.compl` | `{Symbol : Type} [Inhabited Symbol] {p : ωLanguage Symbol} (h : p.IsRegular) : (pᶜ).IsRegular` | PUBLIC |

## Proof Wanted

| # | Name | Signature |
|---|------|-----------|
| 1 | `IsRegular.iff_da_muller` | `p.IsRegular ↔ ∃ (State : Type) (_ : Finite State) (da : DA.Muller State Symbol), language da = p` (McNaughton's Theorem) |

## Statistics
- Theorems/Lemmas: 16 (plus 1 private helper, 1 proof_wanted)
- Definitions: 1
- Lines of code: 267
- Imports: Cslib.Computability.Automata.DA.Buchi, NA.{BuchiEquiv,BuchiInter,Sum}, Languages.Congruences.BuchiCongruence, Languages.ExampleEventuallyZero, Mathlib.Data.{Finite.Card,Finite.Sigma}, Mathlib.Logic.Equiv.Fin.Basic
