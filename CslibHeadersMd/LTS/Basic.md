# Header: Cslib.Foundations.Semantics.LTS.Basic

## Module summary

Defines Labelled Transition Systems (LTS) as a structure with a transition relation `Tr`, and extends
this to multistep transitions (`MTr`) with a finite trace of labels. Provides reachability, image
operations (`image`, `setImage`, `setImageMultistep`), and standard LTS classifications
(deterministic, image-finite, finitely branching, acyclic, finite).

## Vocabulary

### Structures

- `LTS (State : Type u) (Label : Type v)` -- A labelled transition system with a transition relation `Tr : State -> Label -> State -> Prop`.

### Inductives

- `MTr (lts : LTS State Label) : State -> List Label -> State -> Prop` -- Multistep transition relation. Constructors: `refl` (empty trace, same state) and `stepL` (prepend one step).

### Classes

- `Deterministic (lts : LTS State Label)` -- At most one derivative per state-label pair.
- `FinitelyBranching` -- Image-finite with finite outgoing label sets at every state.
- `Acyclic (lts : LTS State Label)` -- Bounded trace length for all multistep transitions.
- `FiniteLTS [Finite State] (lts : LTS State Label)` -- Finite-state and acyclic.

### Definitions

- `CanReach (s1 s2 : State) : Prop` -- Existential: some trace connects s1 to s2 via MTr.
- `generatedBy (s : State)` -- Sub-LTS restricted to states reachable from s.
- `image (s : State) (mu : Label) : Set State` -- Set of mu-derivatives of s.
- `imageMultistep (s : State) (mus : List Label) : Set State` -- Set of mus-derivatives of s.
- `setImage (S : Set State) (mu : Label) : Set State` -- Union of images over a set of states.
- `setImageMultistep (S : Set State) (mus : List Label) : Set State` -- Union of multistep images over a set of states.
- `ImageFinite` -- Abbreviation: all images of all states are finite.
- `HasOutLabel (s : State) (mu : Label) : Prop` -- State s has at least one mu-derivative.
- `outgoingLabels (s : State)` -- Set of labels for which s has a derivative.

## Theorem listing

### STRUCTURAL (properties of MTr and the transition relation)

```
ProvenTheorem MTr.single :
    forall {State Label} (lts : LTS State Label) {s1 : State} {mu : Label} {s2 : State},
    lts.Tr s1 mu s2 -> lts.MTr s1 [mu] s2
```

```
ProvenTheorem MTr.stepR :
    forall {State Label} (lts : LTS State Label) {s1 : State} {mus : List Label} {s2 : State}
    {mu : Label} {s3 : State},
    lts.MTr s1 mus s2 -> lts.Tr s2 mu s3 -> lts.MTr s1 (mus ++ [mu]) s3
```

```
ProvenTheorem MTr.comp :
    forall {State Label} (lts : LTS State Label) {s1 : State} {mus1 : List Label} {s2 : State}
    {mus2 : List Label} {s3 : State},
    lts.MTr s1 mus1 s2 -> lts.MTr s2 mus2 s3 -> lts.MTr s1 (mus1 ++ mus2) s3
```

```
ProvenTheorem MTr.single_invert :
    forall {State Label} (lts : LTS State Label) (s1 : State) (mu : Label) (s2 : State),
    lts.MTr s1 [mu] s2 -> lts.Tr s1 mu s2
```

```
ProvenTheorem MTr.nil_eq :
    forall {State Label} (lts : LTS State Label) {s1 s2 : State},
    lts.MTr s1 [] s2 -> s1 = s2
```

```
ProvenTheorem CanReach.refl :
    forall {State Label} (lts : LTS State Label) (s : State),
    lts.CanReach s s
```

### DERIVED (image operations and characterisations)

```
ProvenTheorem mem_setImage :
    forall {State Label} {lts : LTS State Label} {s' : State} {S : Set State} {mu : Label},
    s' in lts.setImage S mu <-> exists s in S, lts.Tr s mu s'
```

```
ProvenTheorem tr_setImage :
    forall {State Label} {lts : LTS State Label} {s : State} {S : Set State} {mu : Label}
    {s' : State},
    s in S -> lts.Tr s mu s' -> s' in lts.setImage S mu
```

```
ProvenTheorem mem_setImageMultistep :
    forall {State Label} {lts : LTS State Label} {s' : State} {S : Set State} {mus : List Label},
    s' in lts.setImageMultistep S mus <-> exists s in S, lts.MTr s mus s'
```

```
ProvenTheorem mTr_setImage :
    forall {State Label} {lts : LTS State Label} {s : State} {S : Set State} {mus : List Label}
    {s' : State},
    s in S -> lts.MTr s mus s' -> s' in lts.setImageMultistep S mus
```

```
ProvenTheorem setImage_empty :
    forall {State Label} (lts : LTS State Label) {mu : Label},
    lts.setImage {} mu = {}
```

```
ProvenLemma setImageMultistep_setImage_head :
    forall {State Label} (lts : LTS State Label) {S : Set State} {mu : Label} {mus : List Label},
    lts.setImageMultistep S (mu :: mus) = lts.setImageMultistep (lts.setImage S mu) mus
```

```
ProvenTheorem setImageMultistep_foldl_setImage :
    forall {State Label} (lts : LTS State Label),
    lts.setImageMultistep = List.foldl lts.setImage
```

```
ProvenTheorem mem_foldl_setImage :
    forall {State Label} (lts : LTS State Label) {s' : State} {S : Set State} {mus : List Label},
    s' in List.foldl lts.setImage S mus <-> exists s in S, lts.MTr s mus s'
```

### DERIVED (deterministic LTS properties)

```
ProvenTheorem deterministic_not_lto :
    forall {State Label} (lts : LTS State Label) [h : lts.Deterministic],
    forall (s : State) (mu : Label) (s' s'' : State),
    s' != s'' -> lts.Tr s mu s' -> not (lts.Tr s mu s'')
```

```
ProvenTheorem deterministic_tr_image_singleton :
    forall {State Label} {lts : LTS State Label} [inst : lts.Deterministic] {s : State}
    {mu : Label} {s' : State},
    lts.image s mu = {s'} <-> lts.Tr s mu s'
```

```
ProvenTheorem deterministic_image_char :
    forall {State Label} (lts : LTS State Label) [inst : lts.Deterministic]
    (s : State) (mu : Label),
    (exists s', lts.image s mu = {s'}) \/ (lts.image s mu = {})
```

### DERIVED (class implications)

```
ProvenInstance deterministic_imageFinite :
    forall {State Label} (lts : LTS State Label) [inst : lts.Deterministic],
    lts.ImageFinite
```

```
ProvenInstance finiteState_imageFinite :
    forall {State Label} (lts : LTS State Label) [inst : Finite State],
    lts.ImageFinite
```

```
ProvenInstance FinitelyBranching.of_finite :
    forall {State Label} (lts : LTS State Label) [inst1 : Finite State] [inst2 : Finite Label],
    lts.FinitelyBranching
```

## Dependencies

- `Cslib.Init`
- `Mathlib.Data.Set.Finite.Basic`
- `Mathlib.Order.SetNotation`

## Statistics

- **Structures**: 1 (LTS)
- **Inductives**: 1 (MTr)
- **Classes**: 4 (Deterministic, FinitelyBranching, Acyclic, FiniteLTS)
- **Definitions**: 9
- **Theorems/Lemmas**: 17
- **Instances**: 3 (deterministic_imageFinite, finiteState_imageFinite, FinitelyBranching.of_finite)
- **Lines**: 306
