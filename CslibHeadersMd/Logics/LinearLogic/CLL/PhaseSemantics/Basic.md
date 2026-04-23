# CLL.PhaseSemantics.Basic

Phase semantics for CLL: phase spaces, orthogonality, facts, and interpretation of all CLL connectives as operations on facts.

## Vocabulary

| Name | Kind | Description |
|------|------|-------------|
| `PhaseSpace` | class | Commutative monoid with a distinguished subset bot |
| `orthogonal` | def | Orthogonal of a set X: elements mapping X into bot |
| `isFact` | def | A set equals its biorthogonal closure |
| `Fact` | structure | Type of facts (carrier + proof) |
| `Fact.tensor`, `Fact.parr`, `Fact.linImpl` | def | Multiplicative connectives on facts |
| `Fact.withh`, `Fact.oplus` | def | Additive connectives on facts |
| `Fact.bang`, `Fact.quest` | def | Exponential connectives on facts |
| `interpProp` | def | Interpretation of CLL propositions as facts |

## Theorems (selected)

| # | Name | Signature | Visibility |
|---|------|-----------|------------|
| 1 | `triple_orth` | `X⫠⫠⫠ = X⫠` | PUBLIC |
| 2 | `biorth_least_fact` | `isFact F → G ⊆ F → G⫠⫠ ⊆ F` | PUBLIC |
| 3 | `sInf_isFact` | Arbitrary intersections of facts are facts | PUBLIC |
| 4 | `tensor_assoc` | `(G ⊗ H) ⊗ K = G ⊗ (H ⊗ K)` | PUBLIC |
| 5 | `tensor_distrib_plus` | `G ⊗ (H ⊕ K) = (G ⊗ H) ⊕ (G ⊗ K)` | PUBLIC |
| 6 | `par_distrib_with` | `G ⅋ (H & K) = (G ⅋ H) & (G ⅋ K)` | PUBLIC |
| 7 | `neg_tensor` | `(G ⊗ H)ᗮ = Gᗮ ⅋ Hᗮ` | PUBLIC |

## Statistics

- **Theorems/Lemmas**: 40+
- **Lines of code**: 707
- **Authors**: Tanner Duve, Bhavik Mehta
