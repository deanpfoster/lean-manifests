# Cslib.Foundations.Semantics.FLTS.LTSToFLTS

## Module Summary

Converts an `LTS` to an `FLTS` via the subset (powerset) construction (`toFLTS`). Characterizes transitions and multi-step transitions of the resulting FLTS in terms of the original LTS.

## Vocabulary

| Name | Kind | Description |
|------|------|-------------|
| `LTS.toFLTS` | def | Subset construction: `FLTS (Set State) Label` where `tr := lts.setImage` |

## Theorems

### PUBLIC

| # | Name | Signature |
|---|------|-----------|
| 1 | `toFLTS_mem_tr` | `theorem toFLTS_mem_tr {lts : LTS State Label} {S : Set State} {s' : State} {mu : Label} : s' in lts.toFLTS.tr S mu <-> exists s in S, lts.Tr s mu s'` |
| 2 | `toFLTS_mem_mtr` | `theorem toFLTS_mem_mtr {lts : LTS State Label} {S : Set State} {s' : State} {mus : List Label} : s' in lts.toFLTS.mtr S mus <-> exists s in S, lts.MTr s mus s'` |
| 3 | `toFLTS_mtr_setImageMultistep` | `theorem toFLTS_mtr_setImageMultistep {lts : LTS State Label} : lts.toFLTS.mtr = lts.setImageMultistep` |

### INTERNAL

None.

## Counts

- **PUBLIC**: 3
- **INTERNAL**: 0
