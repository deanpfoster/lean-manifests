# Cslib.Foundations.Semantics.FLTS.FLTSToLTS

## Module Summary

Converts an `FLTS` to an `LTS` via `toLTS` and proves the resulting LTS is deterministic and image-finite. Characterizes single and multi-step transitions.

## Vocabulary

| Name | Kind | Description |
|------|------|-------------|
| `FLTS.toLTS` | def | Convert FLTS to LTS: `Tr s1 mu s2 := flts.tr s1 mu = s2` |

## Theorems

### PUBLIC

| # | Name | Signature |
|---|------|-----------|
| 1 | `toLTS_tr` | `theorem toLTS_tr {flts : FLTS State Label} {s1 : State} {mu : Label} {s2 : State} : flts.toLTS.Tr s1 mu s2 <-> flts.tr s1 mu = s2` |
| 2 | `toLTS_deterministic` | `instance toLTS_deterministic (flts : FLTS State Label) : flts.toLTS.Deterministic` |
| 3 | `toLTS_imageFinite` | `instance toLTS_imageFinite (flts : FLTS State Label) : flts.toLTS.ImageFinite` |
| 4 | `toLTS_mtr` | `theorem toLTS_mtr {flts : FLTS State Label} {s1 : State} {mus : List Label} {s2 : State} : flts.toLTS.MTr s1 mus s2 <-> flts.mtr s1 mus = s2` |

### INTERNAL

None.

## Counts

- **PUBLIC**: 4
- **INTERNAL**: 0
