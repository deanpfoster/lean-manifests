# Cslib.Foundations.Semantics.LTS.OmegaExecution

## Module Summary

Defines infinite executions (`OmegaExecution`) of LTSs, proves extraction of finite sub-executions/MTr from infinite ones, prepending with transitions and finite executions, and concatenation of infinite sequences of finite executions via `flatten`.

## Vocabulary

| Name | Kind | Description |
|------|------|-------------|
| `LTS.OmegaExecution` | def | `forall i, lts.Tr (ss i) (mus i) (ss (i + 1))` |

## Theorems

### PUBLIC

| # | Name | Signature |
|---|------|-----------|
| 1 | `OmegaExecution.extract_execution` | `theorem OmegaExecution.extract_execution (h : lts.OmegaExecution ss mus) {n m : Nat} (hnm : n <= m) : lts.Execution (ss n) (mus.extract n m) (ss m) (ss.extract n (m + 1))` |
| 2 | `OmegaExecution.extract_mTr` | `theorem OmegaExecution.extract_mTr (h : lts.OmegaExecution ss mus) {n m : Nat} (hnm : n <= m) : lts.MTr (ss n) (mus.extract n m) (ss m)` |
| 3 | `OmegaExecution.cons` | `theorem OmegaExecution.cons (htr : lts.Tr s mu t) (homega : lts.OmegaExecution ss mus) (hm : ss 0 = t) : lts.OmegaExecution (s ::omega ss) (mu ::omega mus)` |
| 4 | `OmegaExecution.append` | `theorem OmegaExecution.append (hmtr : lts.MTr s mul t) (homega : lts.OmegaExecution ss mus) (hm : ss 0 = t) : exists ss', lts.OmegaExecution ss' (mul ++omega mus) and ss' 0 = s and ss' mul.length = t and ss'.drop mul.length = ss` |
| 5 | `OmegaExecution.flatten_execution` | `theorem OmegaExecution.flatten_execution [Inhabited Label] {ts : omegaSequence State} {muls : omegaSequence (List Label)} {sls : omegaSequence (List State)} (hexec : forall k, lts.Execution (ts k) (muls k) (ts (k + 1)) (sls k)) (hpos : forall k, (muls k).length > 0) : exists ss, lts.OmegaExecution ss muls.flatten and forall k, ss.extract (muls.cumLen k) (muls.cumLen (k + 1)) = (sls k).take (muls k).length` |
| 6 | `OmegaExecution.flatten_mTr` | `theorem OmegaExecution.flatten_mTr [Inhabited Label] {ts : omegaSequence State} {muls : omegaSequence (List Label)} (hmtr : forall k, lts.MTr (ts k) (muls k) (ts (k + 1))) (hpos : forall k, (muls k).length > 0) : exists ss, lts.OmegaExecution ss muls.flatten and forall k, ss (muls.cumLen k) = ts k` |

### INTERNAL

None.

## Counts

- **PUBLIC**: 6
- **INTERNAL**: 0
