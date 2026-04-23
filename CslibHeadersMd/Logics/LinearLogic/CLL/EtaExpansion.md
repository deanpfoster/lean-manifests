# CLL.EtaExpansion

Defines eta-expansion for CLL propositions (expanding axioms to only use atomic propositions) and proves its correctness.

## Vocabulary

| Name | Kind | Description |
|------|------|-------------|
| `Proposition.expand` | def | Eta-expansion: proof of `{a, a⫠}` using only atomic axioms |
| `Proof.onlyAtomicAxioms` | def | Boolean: all axiom instances are atomic |

## Theorems

| # | Name | Signature | Visibility |
|---|------|-----------|------------|
| 1 | `Proof.expand_onlyAtomicAxioms` | `a.expand.onlyAtomicAxioms` | PUBLIC |

## Statistics

- **Theorems/Lemmas**: 1
- **Lines of code**: 137
- **Authors**: Fabrizio Montesi
