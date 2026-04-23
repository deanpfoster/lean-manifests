# Cslib.Computability.Automata.NA.Pair

## Summary
Defines pair languages and pair-via languages for LTS (languages of words moving between two states, optionally via an intermediate accepting state). Proves regularity of these languages for finite-state systems and a key decomposition theorem expressing finite-state Buchi automaton languages as finite unions of L * M^omega.

## Vocabulary
| Name | Kind | Description |
|------|------|-------------|
| `LTS.pairLang` | def | Language of words moving LTS from state s to state t |
| `LTS.pairViaLang` | def | Language of words moving LTS from s to t via some state in a set |

## Theorems

| # | Name | Signature | Visibility |
|---|------|-----------|------------|
| 1 | `LTS.mem_pairLang` | `{lts : LTS State Symbol} {s t : State} {xs : List Symbol} : xs ∈ lts.pairLang s t ↔ lts.MTr s xs t` | PUBLIC |
| 2 | `LTS.pairLang_regular` | `[Finite State] {lts : LTS State Symbol} {s t : State} : (lts.pairLang s t).IsRegular` | PUBLIC |
| 3 | `LTS.mem_pairViaLang` | `{lts : LTS State Symbol} {via : Set State} {s t : State} {xs : List Symbol} : xs ∈ lts.pairViaLang via s t ↔ ∃ r ∈ via, ∃ xs1 xs2, lts.MTr s xs1 r ∧ lts.MTr r xs2 t ∧ xs1 ++ xs2 = xs` | PUBLIC |
| 4 | `LTS.pairViaLang_regular` | `[Inhabited Symbol] [Finite State] {lts : LTS State Symbol} {via : Set State} {s t : State} : (lts.pairViaLang via s t).IsRegular` | PUBLIC |
| 5 | `LTS.pairLang_append` | `(h1 : xs1 ∈ lts.pairLang s0 s1) (h2 : xs2 ∈ lts.pairLang s1 s2) : xs1 ++ xs2 ∈ lts.pairLang s0 s2` | PUBLIC |
| 6 | `LTS.pairLang_split` | `(h : xs1 ++ xs2 ∈ lts.pairLang s0 s2) : ∃ s1, xs1 ∈ lts.pairLang s0 s1 ∧ xs2 ∈ lts.pairLang s1 s2` | PUBLIC |
| 7 | `LTS.pairViaLang_append_pairLang` | `(h1 : xs1 ∈ lts.pairViaLang via s0 s1) (h2 : xs2 ∈ lts.pairLang s1 s2) : xs1 ++ xs2 ∈ lts.pairViaLang via s0 s2` | PUBLIC |
| 8 | `LTS.pairLang_append_pairViaLang` | `(h1 : xs1 ∈ lts.pairLang s0 s1) (h2 : xs2 ∈ lts.pairViaLang via s1 s2) : xs1 ++ xs2 ∈ lts.pairViaLang via s0 s2` | PUBLIC |
| 9 | `LTS.pairViaLang_split` | `(h : xs1 ++ xs2 ∈ lts.pairViaLang via s0 s2) : ∃ s1, xs1 ∈ lts.pairViaLang via s0 s1 ∧ xs2 ∈ lts.pairLang s1 s2 ∨ xs1 ∈ lts.pairLang s0 s1 ∧ xs2 ∈ lts.pairViaLang via s1 s2` | PUBLIC |
| 10 | `NA.Buchi.language_eq_fin_iSup_hmul_omegaPow` | `[Inhabited Symbol] [Finite State] (na : Buchi State Symbol) : language na = ⨆ s ∈ na.start, ⨆ t ∈ na.accept, (na.pairLang s t) * (na.pairLang t t)^ω` | PUBLIC |

## Statistics
- Theorems/Lemmas: 10
- Definitions: 2
- Lines of code: 148
- Imports: Cslib.Computability.Languages.RegularLanguage
