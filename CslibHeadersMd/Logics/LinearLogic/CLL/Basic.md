# CLL.Basic

Classical Linear Logic: propositions, duality, sequent calculus proofs, proof-relevant and proof-irrelevant equivalences, congruence, and many algebraic identities.

## Vocabulary

| Name | Kind | Description |
|------|------|-------------|
| `Proposition` | inductive | CLL formulas: atom, atomDual, 1, 0, top, bot, tensor, parr, oplus, with, bang, quest |
| `Proposition.dual` | def | Propositional duality (involution) |
| `Sequent` | abbrev | Multiset of propositions |
| `Proof` | inductive | Sequent calculus proofs (14 rules including cut) |
| `Proposition.equiv` | def | Proof-relevant equivalence |
| `Proposition.Equiv` | def | Proof-irrelevant equivalence |

## Theorems (selected)

| # | Name | Signature | Visibility |
|---|------|-----------|------------|
| 1 | `dual_involution` | `a⫠⫠ = a` | PUBLIC |
| 2 | `dual_inj` | `a⫠ = b⫠ ↔ a = b` | PUBLIC |
| 3 | `tensor_distrib_oplus` | `a ⊗ (b ⊕ c) ≡⇓ (a ⊗ b) ⊕ (a ⊗ c)` | PUBLIC |
| 4 | `tensor_symm` | `a ⊗ b ≡⇓ b ⊗ a` | PUBLIC |
| 5 | `tensor_assoc` | `a ⊗ (b ⊗ c) ≡⇓ (a ⊗ b) ⊗ c` | PUBLIC |
| 6 | `oplus_idem` | `a ⊕ a ≡⇓ a` | PUBLIC |
| 7 | `with_idem` | `a & a ≡⇓ a` | PUBLIC |
| 8 | `Congruence` | instance: equivalence is a congruence | PUBLIC |
| 9 | `LogicalEquivalence` | instance | PUBLIC |

## Statistics

- **Theorems/Lemmas**: 9 major + many private congruence lemmas
- **Lines of code**: 703
- **Authors**: Fabrizio Montesi
