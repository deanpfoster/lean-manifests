# LambdaCalculus.LocallyNameless.Stlc.Safety

Type safety for the STLC: preservation and progress for full beta-reduction, plus a general confluence-preserves-typing theorem.

## Vocabulary

| Name | Kind | Description |
|------|------|-------------|
| `PreservesTyping` | def | A relation preserves typing if related terms have the same type |

## Theorems

| # | Name | Signature | Visibility |
|---|------|-----------|------------|
| 1 | `FullBeta.preservation` | `Γ ⊢ t ∶ τ → t ⭢βᶠ t' → Γ ⊢ t' ∶ τ` | PUBLIC |
| 2 | `FullBeta.progress` | `[] ⊢ t ∶ τ → t.Value ∨ ∃ t', t ⭢βᶠ t'` | PUBLIC |
| 3 | `confluence_preservesTyping` | `Confluent R → PreservesTyping R Base → ... → ∃ d, ...` | PUBLIC |

## Statistics

- **Theorems/Lemmas**: 3 major
- **Lines of code**: 105
- **Authors**: Chris Henson
