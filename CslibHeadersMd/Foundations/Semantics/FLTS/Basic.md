# Cslib.Foundations.Semantics.FLTS.Basic

## Module Summary

Defines `FLTS` (Functional Labelled Transition System): an LTS where transitions are determined by a function. Provides the extended transition function `mtr` (multi-step via `foldl`).

## Vocabulary

| Name | Kind | Description |
|------|------|-------------|
| `FLTS` | structure | Functional LTS with `tr : State -> Label -> State` |
| `FLTS.mtr` | def | Extended transition function: `List.foldl flts.tr s` |

## Theorems

### PUBLIC

| # | Name | Signature |
|---|------|-----------|
| 1 | `mtr_nil_eq` | `theorem mtr_nil_eq {flts : FLTS State Label} {s : State} : flts.mtr s [] = s` |
| 2 | `mtr_concat_eq` | `theorem mtr_concat_eq {flts : FLTS State Label} {s : State} {mus : List Label} {mu : Label} : flts.mtr s (mus ++ [mu]) = flts.tr (flts.mtr s mus) mu` |

### INTERNAL

None.

## Counts

- **PUBLIC**: 2
- **INTERNAL**: 0
