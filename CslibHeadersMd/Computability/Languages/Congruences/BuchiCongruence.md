# Cslib.Computability.Languages.Congruences.BuchiCongruence

## Summary
Defines the Buchi congruence for a Buchi automaton -- a right congruence where two words are equivalent iff they induce the same reachability and via-acceptance between all state pairs. Proves finite index for finite-state automata. Defines the Buchi family of omega-languages and proves it covers all sequences and saturates the accepted language. This is the key technical machinery behind complementation of omega-regular languages.

## Vocabulary
| Name | Kind | Description |
|------|------|-------------|
| `Buchi.BuchiCongruence` | def | Right congruence based on pairLang/pairViaLang equivalence |
| `Buchi.BuchiCongrParam` | def | Parameterization of equivalence classes for finiteness proof |
| `buchiFamily` | def | Family of omega-languages indexed by pairs of congruence classes |

## Theorems

| # | Name | Signature | Visibility |
|---|------|-----------|------------|
| 1 | `buchiCongrParam_surjective` | `Surjective na.BuchiCongrParam` | INTERNAL |
| 2 | `buchiCongruence_fin_index` | `[Finite State] : Finite (Quotient na.BuchiCongruence.eq)` | PUBLIC |
| 3 | `buchiCongruence_transfer` | `{a : Quotient na.BuchiCongruence.eq} {xl yl : List Symbol} {s t : State} (hc : xl ∈ na.BuchiCongruence.eqvCls a) (hc' : yl ∈ na.BuchiCongruence.eqvCls a) (hp : xl ∈ na.pairLang s t) : ∃ sl, na.Execution s yl t sl ∧ (xl ∈ na.pairViaLang na.accept s t → ∃ r ∈ na.accept, r ∈ sl)` | PUBLIC |
| 4 | `mem_buchiFamily` | `{xs : ωSequence Symbol} {a b : Quotient na.BuchiCongruence.eq} : xs ∈ na.buchiFamily (a, b) ↔ ...` | PUBLIC |
| 5 | `buchiFamily_cover` | `[Inhabited Symbol] [Finite State] : ⨆ i, na.buchiFamily i = ⊤` | PUBLIC |
| 6 | `buchiFamily_saturation` | `[Inhabited Symbol] : Saturates (fun i ↦ (na.buchiFamily i).toSet) (language na).toSet` | PUBLIC |

## Statistics
- Theorems/Lemmas: 6 (plus 1 private helper lemma)
- Definitions: 3
- Lines of code: 230
- Imports: Cslib.Computability.Automata.NA.Pair, Cslib.Foundations.Combinatorics.InfiniteGraphRamsey, Cslib.Foundations.Data.Set.Saturation
