# Cslib.Computability.Automata.NA.Sum

## Summary
Defines the sum (disjoint union) of an indexed family of nondeterministic automata using sigma types, and proves the Buchi language of the sum equals the union of component languages.

## Vocabulary
| Name | Kind | Description |
|------|------|-------------|
| `NA.iSum` | def | Sum of indexed family of NAs with sigma-type states |

## Theorems

| # | Name | Signature | Visibility |
|---|------|-----------|------------|
| 1 | `iSum_run_iff` | `{na : (i : I) → NA (State i) Symbol} {xs : ωSequence Symbol} {ss : ωSequence (Σ i, State i)} : (iSum na).Run xs ss ↔ ∃ i ss_i, (na i).Run xs ss_i ∧ ss_i.map (Sigma.mk i) = ss` | PUBLIC |
| 2 | `Buchi.iSum_language_eq` | `{na : (i : I) → NA (State i) Symbol} {acc : (i : I) → Set (State i)} : language (Buchi.mk (iSum na) (⋃ i, Sigma.mk i '' (acc i))) = ⨆ i, language (Buchi.mk (na i) (acc i))` | PUBLIC |

## Statistics
- Theorems/Lemmas: 2
- Definitions: 1
- Lines of code: 84
- Imports: Cslib.Computability.Automata.NA.Basic
