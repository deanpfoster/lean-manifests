# Cslib.Foundations.Semantics.LTS.Simulation

## Module Summary

Defines simulation, similarity, and simulation equivalence for LTSs. Proves composition of simulations, transitivity and reflexivity of similarity, and that simulation equivalence is an equivalence relation.

## Vocabulary

| Name | Kind | Description |
|------|------|-------------|
| `IsSimulation` | def | Forward simulation: related states can mimic transitions |
| `IsHomSimulation` | abbrev | Simulation on the same LTS |
| `Similarity` | def | Largest simulation (existential) |
| `HomSimilarity` | abbrev | Similarity on the same LTS |
| `SimulationEquiv` | def | Mutual similarity |
| `HomSimulationEquiv` | abbrev | Simulation equivalence on the same LTS |

## Theorems

### PUBLIC

| # | Name | Signature |
|---|------|-----------|
| 1 | `HomSimilarity.refl` | `theorem HomSimilarity.refl (s : State) : s <=[lts] s` |
| 2 | `IsSimulation.comp` | `theorem IsSimulation.comp (r1 : State1 -> State2 -> Prop) (r2 : State2 -> State3 -> Prop) (h1 : IsSimulation lts1 lts2 r1) (h2 : IsSimulation lts2 lts3 r2) : IsSimulation lts1 lts3 (Relation.Comp r1 r2)` |
| 3 | `Similarity.trans` | `theorem Similarity.trans (h1 : s1 <=[lts1,lts2] s2) (h2 : s2 <=[lts2,lts3] s3) : s1 <=[lts1,lts3] s3` |
| 4 | `HomSimulationEquiv.refl` | `theorem HomSimulationEquiv.refl (s : State) : s <=>[lts] s` |
| 5 | `SimulationEquiv.symm` | `theorem SimulationEquiv.symm {s1 s2 : State} (h : s1 <=>[lts1,lts2] s2) : s2 <=>[lts2, lts1] s1` |
| 6 | `SimulationEquiv.trans` | `theorem SimulationEquiv.trans (h1 : s1 <=>[lts1,lts2] s2) (h2 : s2 <=>[lts2,lts3] s3) : s1 <=>[lts1,lts3] s3` |
| 7 | `HomSimulationEquiv.eqv` | `theorem HomSimulationEquiv.eqv : Equivalence (. <=>[lts] .)` |

### INTERNAL

None.

## Counts

- **PUBLIC**: 7
- **INTERNAL**: 0
