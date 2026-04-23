# Propositional.Defs

Defines propositional logic: propositions, theories, intuitionistic and classical theories, and the intuitionistic completion construction.

## Vocabulary

| Name | Kind | Description |
|------|------|-------------|
| `Proposition` | inductive | Propositional formulas: atom, and, or, impl |
| `Theory` | abbrev | `Set (Proposition Atom)` |
| `Theory.IPL` | abbrev | Intuitionistic propositional logic (ex falso) |
| `Theory.CPL` | abbrev | Classical propositional logic (DNE) |
| `IsIntuitionistic` | class | A theory validates ex falso quodlibet |
| `IsClassical` | class | A theory validates double negation elimination |
| `intuitionisticCompletion` | def | Freely generated intuitionistic extension of a theory |

## Theorems

| # | Name | Signature | Visibility |
|---|------|-----------|------------|
| 1 | `isIntuitionisticIff` | `IsIntuitionistic T ↔ IPL ⊆ T` | PUBLIC |
| 2 | `isClassicalIff` | `IsClassical T ↔ CPL ⊆ T` | PUBLIC |
| 3 | `instIsIntuitionisticExtention` | `IsIntuitionistic T → T ⊆ T' → IsIntuitionistic T'` | PUBLIC |
| 4 | `instIsClassicalExtention` | `IsClassical T → T ⊆ T' → IsClassical T'` | PUBLIC |

## Statistics

- **Theorems/Lemmas**: 4
- **Lines of code**: 159
- **Authors**: Thomas Waring
