# Cslib.Foundations.Semantics.LTS.Relation

## Module Summary

Conversions between LTS transition relations and plain relations. Provides `Tr.toRelation` (fix a label), `Relation.toLTS` (embed a relation as an LTS), `MTr.toRelation`, and `Trans` instances enabling `calc` chains for transitions and multi-step transitions.

## Vocabulary

| Name | Kind | Description |
|------|------|-------------|
| `LTS.Tr.toRelation` | def | Fix a label `mu` to get a binary relation on states |
| `LTS.Relation.toLTS` | def | Embed a binary relation as an LTS with a fixed label |
| `LTS.MTr.toRelation` | def | Fix a label list `mus` to get a binary relation on states |

## Theorems

### PUBLIC

(Four `Trans` instances for `calc` support)

| # | Name | Signature |
|---|------|-----------|
| 1 | `Trans Tr Tr MTr` | `instance (lts) : Trans (Tr.toRelation lts mu1) (Tr.toRelation lts mu2) (MTr.toRelation lts [mu1, mu2])` |
| 2 | `Trans Tr MTr MTr` | `instance (lts) : Trans (Tr.toRelation lts mu) (MTr.toRelation lts mus) (MTr.toRelation lts (mu :: mus))` |
| 3 | `Trans MTr Tr MTr` | `instance (lts) : Trans (MTr.toRelation lts mus) (Tr.toRelation lts mu) (MTr.toRelation lts (mus ++ [mu]))` |
| 4 | `Trans MTr MTr MTr` | `instance (lts) : Trans (MTr.toRelation lts mus1) (MTr.toRelation lts mus2) (MTr.toRelation lts (mus1 ++ mus2))` |

### INTERNAL

None.

## Counts

- **PUBLIC**: 4
- **INTERNAL**: 0
