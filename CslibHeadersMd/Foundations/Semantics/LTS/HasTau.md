# Cslib.Foundations.Semantics.LTS.HasTau

## Module Summary

Defines LTSs with a special internal transition label tau (`HasTau`). Provides saturated transitions (`tauSTr`, `STr`), LTS saturation (`saturate`), tau-closure, and proofs that saturation is idempotent.

## Vocabulary

| Name | Kind | Description |
|------|------|-------------|
| `HasTau` | class | Label type with a distinguished `tau` element |
| `LTS.tauSTr` | def | Reflexive-transitive closure of tau-transitions |
| `LTS.STr` | inductive | Saturated transition: tau-star, visible, tau-star |
| `LTS.saturate` | def | LTS with `STr` as its transition relation |
| `LTS.tauClosure` | def | tau-closure of a set of states |

## Theorems

### PUBLIC

| # | Name | Signature |
|---|------|-----------|
| 1 | `STr.single` | `theorem STr.single [HasTau Label] (lts : LTS State Label) : lts.Tr s mu s' -> lts.STr s mu s'` |
| 2 | `sTr_tauSTr` | `theorem sTr_tauSTr [HasTau Label] (lts : LTS State Label) : lts.STr s HasTau.tau s' <-> lts.tauSTr s s'` |
| 3 | `saturate_tauSTr_tauSTr` | `theorem saturate_tauSTr_tauSTr [HasTau Label] (lts : LTS State Label) : lts.saturate.tauSTr s = lts.tauSTr s` |
| 4 | `STr.trans_tau` | `theorem STr.trans_tau [HasTau Label] (lts : LTS State Label) (h1 : lts.STr s1 HasTau.tau s2) (h2 : lts.STr s2 HasTau.tau s3) : lts.STr s1 HasTau.tau s3` |
| 5 | `STr.comp` | `theorem STr.comp [HasTau Label] (lts : LTS State Label) (h1 : lts.STr s1 HasTau.tau s2) (h2 : lts.STr s2 mu s3) (h3 : lts.STr s3 HasTau.tau s4) : lts.STr s1 mu s4` |
| 6 | `mem_saturate_image_tau` | `theorem mem_saturate_image_tau [HasTau Label] (lts : LTS State Label) : s in lts.saturate.image s HasTau.tau` |

### INTERNAL

| # | Name | Signature |
|---|------|-----------|
| 1 | `saturate_tr_sTr` | `theorem saturate_tr_sTr [HasTau Label] {lts : LTS State Label} : lts.saturate.Tr = lts.STr` |
| 2 | `saturate_tr_saturate_sTr` | `theorem saturate_tr_saturate_sTr [HasTau Label] (lts : LTS State Label) (hmu : mu = HasTau.tau) : lts.saturate.Tr s mu = lts.saturate.STr s mu` |

## Counts

- **PUBLIC**: 6
- **INTERNAL**: 2
