# HML.LogicalEquivalence

Defines logical equivalence for HML propositions and instantiates it as a congruence and a `LogicalEquivalence`.

## Vocabulary

| Name | Kind | Description |
|------|------|-------------|
| `Proposition.Equiv` | def | Two propositions are equivalent if they have the same denotation in all LTSs |
| `Proposition.Context` | inductive | Single-hole propositional contexts |
| `Satisfies.Judgement` | structure | Bundled (lts, state, proposition) |

## Theorems

| # | Name | Signature | Visibility |
|---|------|-----------|------------|
| 1 | `Congruence` | instance: equivalence is a congruence for HML propositions | PUBLIC |
| 2 | `LogicalEquivalence` | instance: HML equivalence is a logical equivalence | PUBLIC |

## Statistics

- **Theorems/Lemmas**: 2 instances
- **Lines of code**: 116
- **Authors**: Fabrizio Montesi
