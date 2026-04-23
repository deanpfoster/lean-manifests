# CLL.MLL

Multiplicative Linear Logic (MLL) defined as a fragment of CLL via subtypes. Defines predicates `IsMLL` for propositions and proofs, and bundled MLL types.

## Vocabulary

| Name | Kind | Description |
|------|------|-------------|
| `Proposition.IsMLL` | def | A proposition is in the multiplicative fragment |
| `Proof.IsMLL` | def | A proof uses only MLL rules |
| `MLL.Proposition` | abbrev | `{a : CLL.Proposition // a.IsMLL}` |
| `MLL.Proof` | abbrev | MLL derivations |

## Theorems

| # | Name | Signature | Visibility |
|---|------|-----------|------------|
| 1 | `Proposition.isMLL_dual` | `a.IsMLL → a⫠.IsMLL` | PUBLIC |
| 2 | `Proof.isMLL_sequent` | `p.IsMLL → Γ.IsMLL` | PUBLIC |

## Statistics

- **Theorems/Lemmas**: 2
- **Lines of code**: 141
- **Authors**: Fabrizio Montesi
