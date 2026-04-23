# Cslib.Computability.Automata.NA.BuchiInter

## Summary
Implements the intersection of two nondeterministic Buchi automata using a product construction augmented with a boolean history state that tracks alternating acceptance. Proves the intersection automaton's language equals the intersection of the component languages.

## Vocabulary
| Name | Kind | Description |
|------|------|-------------|
| `Buchi.histStart` | def | Initial history state (false) |
| `Buchi.interAcc` | def | Accepting conditions for one component |
| `Buchi.histTrans` | def | Transition function for the boolean history state |
| `Buchi.interNA` | def | The intersection automaton (product + history) |
| `Buchi.interAccept` | def | Overall accepting condition (union of both component conditions) |

## Theorems

| # | Name | Signature | Visibility |
|---|------|-----------|------------|
| 1 | `inter_freq_acc_freq_acc` | `(h_run : (interNA na acc).Run xs ss) (h_inf : ∃ᶠ k in atTop, ss k ∈ interAcc i acc) : ∃ᶠ k in atTop, ss k ∈ interAcc (!i) acc` | INTERNAL |
| 2 | `inter_freq_comp_acc_freq_acc` | `(h_run : (interNA na acc).Run xs ss) (h_inf_f : ∃ᶠ k in atTop, ss k ∈ {s \| s.fst false ∈ acc false}) (h_inf_t : ∃ᶠ k in atTop, ss k ∈ {s \| s.fst true ∈ acc true}) : ∃ᶠ k in atTop, ss k ∈ interAccept acc` | INTERNAL |
| 3 | `inter_language_eq` | `language (Buchi.mk (interNA na acc) (interAccept acc)) = ⨅ i, language (Buchi.mk (na i) (acc i))` | PUBLIC |

## Statistics
- Theorems/Lemmas: 3 (1 public, 2 internal)
- Definitions: 5
- Lines of code: 136
- Imports: Cslib.Computability.Automata.NA.Hist, Cslib.Computability.Automata.NA.Prod, Cslib.Foundations.Data.OmegaSequence.Temporal
