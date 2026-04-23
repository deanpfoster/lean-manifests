# Cslib.Foundations.Semantics.LTS.TraceEq

## Module Summary

Defines trace equivalence for LTSs: two states are trace equivalent if they have the same set of traces. Proves it is an equivalence relation and that in deterministic LTSs, trace equivalence is a simulation.

## Vocabulary

| Name | Kind | Description |
|------|------|-------------|
| `LTS.traces` | def | Set of label-lists reachable from a state |
| `TraceEq` | def | Same trace sets |
| `HomTraceEq` | abbrev | Trace equivalence on the same LTS |

## Theorems

### PUBLIC

| # | Name | Signature |
|---|------|-----------|
| 1 | `traces_in` | `theorem traces_in {lts : LTS State Label} (h : lts.MTr s mus s') : mus in lts.traces s` |
| 2 | `HomTraceEq.refl` | `theorem HomTraceEq.refl (s : State) : s ~tr[lts] s` |
| 3 | `TraceEq.symm` | `theorem TraceEq.symm (h : s1 ~tr[lts1,lts2] s2) : s2 ~tr[lts2,lts1] s1` |
| 4 | `TraceEq.trans` | `theorem TraceEq.trans (h1 : s1 ~tr[lts1,lts2] s2) (h2 : s2 ~tr[lts2,lts3] s3) : s1 ~tr[lts1,lts3] s3` |
| 5 | `HomTraceEq.eqv` | `theorem HomTraceEq.eqv : Equivalence (. ~tr[lts] .)` |
| 6 | `TraceEq.deterministic_isSimulation` | `theorem TraceEq.deterministic_isSimulation {lts1 : LTS State1 Label} {lts2 : LTS State2 Label} [lts1.Deterministic] [lts2.Deterministic] : IsSimulation lts1 lts2 (TraceEq lts1 lts2)` |

### INTERNAL

None.

## Counts

- **PUBLIC**: 6
- **INTERNAL**: 0
