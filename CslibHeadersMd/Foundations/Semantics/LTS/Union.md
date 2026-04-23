# Cslib.Foundations.Semantics.LTS.Union

## Module Summary

Defines several union constructions for LTSs: `union` (same types, disjunction of transitions), `unionSubtype` (common supertypes with decidable predicates), `inl`/`inr` (liftings to sum types), and `unionSum` (disjoint union via sum types).

## Vocabulary

| Name | Kind | Description |
|------|------|-------------|
| `LTS.union` | def | Union of two LTSs on the same types: `Tr := lts1.Tr sup lts2.Tr` |
| `LTS.unionSubtype` | def | Union of two LTSs with common supertypes for states and labels |
| `LTS.inl` | def | Lift an LTS to `{x : State + State' // x.isLeft}` |
| `LTS.inr` | def | Lift an LTS to `{x : State' + State // x.isRight}` |
| `LTS.unionSum` | def | Union of two LTSs with disjoint state types via `State1 + State2` |

## Theorems

None (definitions only).

## Counts

- **PUBLIC**: 0
- **INTERNAL**: 0
