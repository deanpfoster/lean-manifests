# Cslib.Foundations.Semantics.LTS.Basic

## Module Summary

Core definitions for Labelled Transition Systems: the `LTS` structure, multi-step transitions (`MTr`), reachability (`CanReach`), image operations, and LTS classification (deterministic, image-finite, finitely branching, acyclic, finite).

## Vocabulary

| Name | Kind | Description |
|------|------|-------------|
| `LTS` | structure | Labelled transition system with `Tr : State -> Label -> State -> Prop` |
| `LTS.MTr` | inductive | Multi-step transition: `refl` and `stepL` |
| `LTS.CanReach` | def | Exists a multi-step transition from `s1` to `s2` |
| `LTS.generatedBy` | def | Sub-LTS of all states reachable from a given state |
| `LTS.Deterministic` | class | At most one derivative per state-label |
| `LTS.image` | def | Set of mu-derivatives of a state |
| `LTS.imageMultistep` | def | Set of mus-derivatives of a state |
| `LTS.setImage` | def | mu-image of a set of states |
| `LTS.setImageMultistep` | def | mus-image of a set of states |
| `LTS.ImageFinite` | abbrev | All images are finite |
| `LTS.HasOutLabel` | def | State has an outgoing label |
| `LTS.outgoingLabels` | def | Set of outgoing labels of a state |
| `LTS.FinitelyBranching` | class | Image-finite with finite outgoing labels |
| `LTS.Acyclic` | class | Bounded multi-step length |
| `LTS.FiniteLTS` | class | Finite-state and acyclic |

## Theorems

### PUBLIC

| # | Name | Signature |
|---|------|-----------|
| 1 | `MTr.single` | `theorem MTr.single : lts.Tr s1 mu s2 -> lts.MTr s1 [mu] s2` |
| 2 | `MTr.stepR` | `theorem MTr.stepR : lts.MTr s1 mus s2 -> lts.Tr s2 mu s3 -> lts.MTr s1 (mus ++ [mu]) s3` |
| 3 | `MTr.comp` | `theorem MTr.comp : lts.MTr s1 mus1 s2 -> lts.MTr s2 mus2 s3 -> lts.MTr s1 (mus1 ++ mus2) s3` |
| 4 | `MTr.single_invert` | `theorem MTr.single_invert (s1 : State) (mu : Label) (s2 : State) : lts.MTr s1 [mu] s2 -> lts.Tr s1 mu s2` |
| 5 | `MTr.nil_eq` | `theorem MTr.nil_eq (h : lts.MTr s1 [] s2) : s1 = s2` |
| 6 | `CanReach.refl` | `theorem CanReach.refl (s : State) : lts.CanReach s s` |
| 7 | `mem_setImage` | `theorem mem_setImage {lts : LTS State Label} : s' in lts.setImage S mu <-> exists s in S, lts.Tr s mu s'` |
| 8 | `mem_setImageMultistep` | `theorem mem_setImageMultistep {lts : LTS State Label} : s' in lts.setImageMultistep S mus <-> exists s in S, lts.MTr s mus s'` |
| 9 | `setImage_empty` | `theorem setImage_empty (lts : LTS State Label) : lts.setImage empty mu = empty` |
| 10 | `setImageMultistep_foldl_setImage` | `theorem setImageMultistep_foldl_setImage (lts : LTS State Label) : lts.setImageMultistep = List.foldl lts.setImage` |
| 11 | `mem_foldl_setImage` | `theorem mem_foldl_setImage (lts : LTS State Label) : s' in List.foldl lts.setImage S mus <-> exists s in S, lts.MTr s mus s'` |
| 12 | `deterministic_not_lto` | `theorem deterministic_not_lto [h : lts.Deterministic] : forall s mu s' s'', s' != s'' -> lts.Tr s mu s' -> not (lts.Tr s mu s'')` |
| 13 | `deterministic_tr_image_singleton` | `theorem deterministic_tr_image_singleton [lts.Deterministic] : lts.image s mu = {s'} <-> lts.Tr s mu s'` |
| 14 | `deterministic_image_char` | `theorem deterministic_image_char [lts.Deterministic] (s : State) (mu : Label) : (exists s', lts.image s mu = { s' }) or (lts.image s mu = empty)` |
| 15 | `deterministic_imageFinite` | `instance deterministic_imageFinite [lts.Deterministic] : lts.ImageFinite` |
| 16 | `finiteState_imageFinite` | `instance finiteState_imageFinite [Finite State] : lts.ImageFinite` |

### INTERNAL

| # | Name | Signature |
|---|------|-----------|
| 1 | `tr_setImage` | `theorem tr_setImage {lts : LTS State Label} (hs : s in S) (htr : lts.Tr s mu s') : s' in lts.setImage S mu` |
| 2 | `mTr_setImage` | `theorem mTr_setImage {lts : LTS State Label} (hs : s in S) (htr : lts.MTr s mus s') : s' in lts.setImageMultistep S mus` |
| 3 | `setImageMultistep_setImage_head` | `lemma setImageMultistep_setImage_head (lts : LTS State Label) : lts.setImageMultistep S (mu :: mus) = lts.setImageMultistep (lts.setImage S mu) mus` |

## Counts

- **PUBLIC**: 16
- **INTERNAL**: 3
