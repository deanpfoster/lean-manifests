# Cslib.Computability.Automata.DA.Congr

## Summary
Constructs the deterministic automaton corresponding to a right congruence, where states are equivalence classes, and proves that with a singleton accepting class the language equals that equivalence class.

## Vocabulary
| Name | Kind | Description |
|------|------|-------------|
| `RightCongruence.toDA` | def | DA whose states are quotient classes of a right congruence |

## Theorems

| # | Name | Signature | Visibility |
|---|------|-----------|------------|
| 1 | `congr_mtr_eq` | `[c : RightCongruence Symbol] {xs : List Symbol} : c.toDA.mtr c.toDA.start xs = ⟦ xs ⟧` | PUBLIC |
| 2 | `FinAcc.congr_language_eq` | `[c : RightCongruence Symbol] {a : Quotient c.eq} : language (FinAcc.mk c.toDA {a}) = eqvCls a` | PUBLIC |

## Statistics
- Theorems/Lemmas: 2
- Definitions: 1
- Lines of code: 72
- Imports: Cslib.Computability.Automata.DA.Basic, Cslib.Computability.Languages.Congruences.RightCongruence
