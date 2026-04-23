# LambdaCalculus.LocallyNameless.Untyped.FullEta

Defines full eta-reduction and proves congruence lemmas.

## Vocabulary

| Name | Kind | Description |
|------|------|-------------|
| `Eta` | inductive | Single eta step: `abs (app M (bvar 0)) ⭢ M` when `M` is LC |
| `FullEta` | abbrev | `Xi Eta` — congruence closure of eta |

## Statistics

- **Theorems/Lemmas**: ~15 congruence/substitution lemmas
- **Lines of code**: 168
- **Authors**: Maximiliano Onofre Martinez
