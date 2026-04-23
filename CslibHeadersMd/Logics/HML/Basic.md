# HML.Basic

Hennessy-Milner Logic (HML): propositions, satisfaction, denotation, theory equivalence, and the characterization theorem equating theory equivalence with bisimilarity for image-finite LTSs.

## Vocabulary

| Name | Kind | Description |
|------|------|-------------|
| `Proposition` | inductive | HML formulas: true, false, and, or, diamond, box |
| `Proposition.neg` | def | De Morgan negation |
| `Satisfies` | inductive | Satisfaction relation for HML |
| `Proposition.denotation` | def | Denotational semantics (set of satisfying states) |
| `theory` | abbrev | The set of all propositions satisfied by a state |
| `TheoryEq` | abbrev | Theory equivalence between two states |

## Theorems

| # | Name | Signature | Visibility |
|---|------|-----------|------------|
| 1 | `satisfies_mem_denotation` | `Satisfies lts s a ↔ s ∈ a.denotation lts` | PUBLIC |
| 2 | `neg_satisfies` | `¬Satisfies lts s a.neg ↔ Satisfies lts s a` | PUBLIC |
| 3 | `satisfies_finiteAnd` | `Satisfies lts s (finiteAnd as) ↔ ∀ a ∈ as, Satisfies lts s a` | PUBLIC |
| 4 | `satisfies_finiteOr` | `Satisfies lts s (finiteOr as) ↔ ∃ a ∈ as, Satisfies lts s a` | PUBLIC |
| 5 | `theoryEq_isBisimulation` | `lts.IsHomBisimulation (TheoryEq lts)` | PUBLIC |
| 6 | `theoryEq_eq_bisimilarity` | `TheoryEq lts = HomBisimilarity lts` | PUBLIC |

## Statistics

- **Theorems/Lemmas**: 6 major
- **Lines of code**: 267
- **Authors**: Fabrizio Montesi, Marco Peressotti, Alexandre Rademaker
