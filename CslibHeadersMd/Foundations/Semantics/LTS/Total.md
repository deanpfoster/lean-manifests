# Cslib.Foundations.Semantics.LTS.Total

## Module Summary

Defines `Total` LTSs (every state has a derivative for every label), proves existence of infinite executions from any state, and defines `totalize` which adds a sink state to make any LTS total. Proves the totalized LTS preserves non-sink transitions exactly.

## Vocabulary

| Name | Kind | Description |
|------|------|-------------|
| `LTS.Total` | class | Every state has a mu-derivative for every label mu |
| `LTS.chooseFLTS` | def (noncomputable) | Choose an FLTS sub-LTS of a total LTS |
| `LTS.chooseOmegaExecution` | def (noncomputable) | Build infinite execution from a starting state |
| `LTS.totalize` | def | Add a sink state (`State + Unit`) to make any LTS total |

## Theorems

### PUBLIC

| # | Name | Signature |
|---|------|-----------|
| 1 | `Total.chooseFLTS` | `theorem Total.chooseFLTS (lts : LTS State Label) [h : lts.Total] (s : State) (mu : Label) : lts.Tr s mu (lts.chooseFLTS.tr s mu)` |
| 2 | `Total.omegaExecution_exists` | `theorem Total.omegaExecution_exists [h : lts.Total] (s : State) (mus : omegaSequence Label) : exists ss, lts.OmegaExecution ss mus and ss 0 = s` |
| 3 | `Total.extend_omegaExecution` | `theorem Total.extend_omegaExecution [Inhabited Label] [ht : lts.Total] {mul : List Label} {s t : State} (hm : lts.MTr s mul t) : exists mus ss, lts.OmegaExecution ss (mul ++omega mus) and ss 0 = s and ss mul.length = t` |
| 4 | `totalize.no_sink_to_nonsink` | `theorem totalize.no_sink_to_nonsink {mus : List Label} {t : State} : not (lts.totalize.MTr (Sum.inr ()) mus (Sum.inl t))` |
| 5 | `totalize.nonsink_tr_iff` | `theorem totalize.nonsink_tr_iff {mu : Label} {s t : State} : lts.totalize.Tr (Sum.inl s) mu (Sum.inl t) <-> lts.Tr s mu t` |
| 6 | `totalize.nonsink_mtr_iff` | `theorem totalize.nonsink_mtr_iff {mus : List Label} {s t : State} : lts.totalize.MTr (Sum.inl s) mus (Sum.inl t) <-> lts.MTr s mus t` |

### INTERNAL

None.

## Counts

- **PUBLIC**: 6
- **INTERNAL**: 0
