# Header: Cslib.Foundations.Semantics.LTS.Bisimulation

## Module summary

Defines bisimulation and bisimilarity for labelled transition systems, including heterogeneous
(two different LTSs) and homogeneous (same LTS) variants. Establishes that bisimilarity is an
equivalence relation, the largest bisimulation, and a greatest fixed point. Also defines weak
bisimulation (via saturated LTSs / HasTau), proves equivalence with the more convenient
sw-bisimulation characterization, and provides bisimulation up-to techniques. Relates bisimilarity
to trace equivalence, proving they coincide for deterministic LTSs.

## Vocabulary

### Definitions

- `IsBisimulation (lts1 : LTS State1 Label) (lts2 : LTS State2 Label) (r : State1 -> State2 -> Prop) : Prop` -- r is a bisimulation: related states mimic each other's transitions with related derivatives.
- `IsHomBisimulation (lts : LTS State Label)` -- Abbreviation for `IsBisimulation lts lts`.
- `Bisimilarity (lts1 : LTS State1 Label) (lts2 : LTS State2 Label) : State1 -> State2 -> Prop` -- Two states are bisimilar if related by some bisimulation.
- `HomBisimilarity (lts : LTS State Label)` -- Abbreviation for `Bisimilarity lts lts`.
- `UpToHomBisimilarity (lts1 lts2) (r)` -- Lifts r by composing with homogeneous bisimilarities on both sides.
- `IsBisimulationUpTo (lts1 lts2) (r) : Prop` -- r is a bisimulation up to homogeneous bisimilarity.
- `IsWeakBisimulation [HasTau Label] (lts1 lts2) (r) : Prop` -- r is a bisimulation on the saturated LTSs (internal actions can be ignored).
- `IsHomWeakBisimulation [HasTau Label] (lts)` -- Abbreviation for `IsWeakBisimulation lts lts`.
- `WeakBisimilarity [HasTau Label] (lts1 lts2) : State1 -> State2 -> Prop` -- Two states are weakly bisimilar if related by some weak bisimulation.
- `HomWeakBisimilarity [HasTau Label] (lts)` -- Abbreviation for `WeakBisimilarity lts lts`.
- `IsSWBisimulation [HasTau Label] (lts1 lts2) (r) : Prop` -- More convenient characterization: challenges are single transitions, responses are saturated transitions (STr).

### Notations

- `s1 ~[lts1,lts2] s2` -- Bisimilarity
- `s1 ~[lts] s2` -- Homogeneous bisimilarity
- `s1 ≈[lts1,lts2] s2` -- Weak bisimilarity
- `s1 ≈[lts] s2` -- Homogeneous weak bisimilarity

### Instances

- `IsEquiv State (HomBisimilarity lts)` -- refl, symm, trans
- `Trans (Bisimilarity lts1 lts2) (Bisimilarity lts2 lts3) (Bisimilarity lts1 lts3)` -- calc support
- `SemilatticeSup {r // IsBisimulation lts1 lts2 r}` -- bisimulations with union form a join-semilattice
- `BoundedOrder {r // IsBisimulation lts1 lts2 r}` -- empty relation is bot, bisimilarity is top

## Theorem listing

### STRUCTURAL (bisimulation definition helpers)

```
ProvenTheorem IsBisimulation.follow_fst :
    forall {State1 State2 Label} {lts1 : LTS State1 Label} {lts2 : LTS State2 Label}
    {r : State1 -> State2 -> Prop} {s1 : State1} {s2 : State2} {mu : Label} {s1' : State1},
    IsBisimulation lts1 lts2 r -> r s1 s2 -> lts1.Tr s1 mu s1' ->
    exists s2', lts2.Tr s2 mu s2' /\ r s1' s2'
```

```
ProvenTheorem IsBisimulation.follow_snd :
    forall {State1 State2 Label} {lts1 : LTS State1 Label} {lts2 : LTS State2 Label}
    {r : State1 -> State2 -> Prop} {s1 : State1} {s2 : State2} {mu : Label} {s2' : State2},
    IsBisimulation lts1 lts2 r -> r s1 s2 -> lts2.Tr s2 mu s2' ->
    exists s1', lts1.Tr s1 mu s1' /\ r s1' s2'
```

### STRUCTURAL (closure properties of bisimulations)

```
ProvenTheorem IsBisimulation.inv :
    forall {State1 State2 Label} {lts1 : LTS State1 Label} {lts2 : LTS State2 Label}
    {r : State1 -> State2 -> Prop},
    IsBisimulation lts1 lts2 r -> IsBisimulation lts2 lts1 (flip r)
```

```
ProvenTheorem IsBisimulation.comp :
    forall {State1 State2 State3 Label} {lts1 : LTS State1 Label} {lts2 : LTS State2 Label}
    {lts3 : LTS State3 Label} {r1 : State1 -> State2 -> Prop} {r2 : State2 -> State3 -> Prop},
    IsBisimulation lts1 lts2 r1 -> IsBisimulation lts2 lts3 r2 ->
    IsBisimulation lts1 lts3 (Relation.Comp r1 r2)
```

```
ProvenTheorem IsBisimulation.sup :
    forall {State1 State2 Label} {lts1 : LTS State1 Label} {lts2 : LTS State2 Label}
    {r s : State1 -> State2 -> Prop},
    IsBisimulation lts1 lts2 r -> IsBisimulation lts1 lts2 s ->
    IsBisimulation lts1 lts2 (r ⊔ s)
```

```
ProvenTheorem IsBisimulation.bot :
    forall {State1 State2 Label} {lts1 : LTS State1 Label} {lts2 : LTS State2 Label},
    IsBisimulation lts1 lts2 Relation.emptyHRelation
```

### EQUIVALENCE (bisimilarity is an equivalence)

```
ProvenTheorem HomBisimilarity.refl :
    forall {State Label} {lts : LTS State Label} (s : State),
    s ~[lts] s
```

```
ProvenTheorem Bisimilarity.symm :
    forall {State1 State2 Label} {lts1 : LTS State1 Label} {lts2 : LTS State2 Label}
    {s1 : State1} {s2 : State2},
    s1 ~[lts1,lts2] s2 -> s2 ~[lts2,lts1] s1
```

```
ProvenTheorem Bisimilarity.trans :
    forall {State1 State2 State3 Label} {lts1 : LTS State1 Label} {lts2 : LTS State2 Label}
    {lts3 : LTS State3 Label} {s1 : State1} {s2 : State2} {s3 : State3},
    s1 ~[lts1,lts2] s2 -> s2 ~[lts2,lts3] s3 -> s1 ~[lts1,lts3] s3
```

```
ProvenTheorem HomBisimilarity.eqv :
    forall {State Label} {lts : LTS State Label},
    Equivalence (HomBisimilarity lts)
```

### EQUIVALENCE (bisimilarity is the largest bisimulation / greatest fixed point)

```
ProvenTheorem Bisimilarity.is_bisimulation :
    forall {State1 State2 Label} {lts1 : LTS State1 Label} {lts2 : LTS State2 Label},
    IsBisimulation lts1 lts2 (Bisimilarity lts1 lts2)
```

```
ProvenTheorem Bisimilarity.largest_bisimulation :
    forall {State1 State2 Label} {lts1 : LTS State1 Label} {lts2 : LTS State2 Label}
    {r : State1 -> State2 -> Prop},
    IsBisimulation lts1 lts2 r -> Subrelation r (Bisimilarity lts1 lts2)
```

```
ProvenTheorem Bisimilarity.gfp :
    forall {State1 State2 Label} {lts1 : LTS State1 Label} {lts2 : LTS State2 Label}
    (r : State1 -> State2 -> Prop),
    IsBisimulation lts1 lts2 r ->
    (Bisimilarity lts1 lts2) ⊔ r = Bisimilarity lts1 lts2
```

### DERIVED (bisimulation up-to)

```
ProvenTheorem IsBisimulationUpTo.is_bisimulation :
    forall {State1 State2 Label} {lts1 : LTS State1 Label} {lts2 : LTS State2 Label}
    {r : State1 -> State2 -> Prop},
    IsBisimulationUpTo lts1 lts2 r ->
    IsBisimulation lts1 lts2 (UpToHomBisimilarity lts1 lts2 r)
```

### DERIVED (multistep bisimulation / trace mimicking)

```
ProvenTheorem IsBisimulation.bisim_trace :
    forall {State1 State2 Label} {lts1 : LTS State1 Label} {lts2 : LTS State2 Label}
    {r : State1 -> State2 -> Prop} {s1 : State1} {s2 : State2},
    IsBisimulation lts1 lts2 r -> r s1 s2 ->
    forall (mus : List Label) (s1' : State1),
    lts1.MTr s1 mus s1' -> exists s2', lts2.MTr s2 mus s2' /\ r s1' s2'
```

### EQUIVALENCE (relation to trace equivalence)

```
ProvenTheorem IsBisimulation.traceEq :
    forall {State1 State2 Label} {lts1 : LTS State1 Label} {lts2 : LTS State2 Label}
    {r : State1 -> State2 -> Prop} {s1 : State1} {s2 : State2},
    IsBisimulation lts1 lts2 r -> r s1 s2 -> s1 ~tr[lts1,lts2] s2
```

```
ProvenTheorem Bisimilarity.le_traceEq :
    forall {State1 State2 Label} {lts1 : LTS State1 Label} {lts2 : LTS State2 Label},
    Bisimilarity lts1 lts2 <= TraceEq lts1 lts2
```

```
ProvenTheorem IsBisimulation.traceEq_not_bisim :
    exists (State : Type) (Label : Type) (lts : LTS State Label),
    not (IsHomBisimulation lts (HomTraceEq lts))
```

```
ProvenTheorem Bisimilarity.bisimilarity_neq_traceEq :
    exists (State : Type) (Label : Type) (lts : LTS State Label),
    HomBisimilarity lts != HomTraceEq lts
```

```
ProvenTheorem IsBisimulation.deterministic_traceEq_isBisimulation :
    forall {State1 State2 Label} {lts1 : LTS State1 Label} {lts2 : LTS State2 Label}
    [inst1 : lts1.Deterministic] [inst2 : lts2.Deterministic],
    IsBisimulation lts1 lts2 (TraceEq lts1 lts2)
```

```
ProvenTheorem Bisimilarity.deterministic_traceEq_bisim :
    forall {State1 State2 Label} {lts1 : LTS State1 Label} {lts2 : LTS State2 Label}
    [inst1 : lts1.Deterministic] [inst2 : lts2.Deterministic] {s1 : State1} {s2 : State2},
    s1 ~tr[lts1,lts2] s2 -> s1 ~[lts1,lts2] s2
```

```
ProvenTheorem Bisimilarity.deterministic_bisim_eq_traceEq :
    forall {State1 State2 Label} {lts1 : LTS State1 Label} {lts2 : LTS State2 Label}
    [inst1 : lts1.Deterministic] [inst2 : lts2.Deterministic],
    Bisimilarity lts1 lts2 = TraceEq lts1 lts2
```

### EQUIVALENCE (relation to simulation)

```
ProvenTheorem IsBisimulation.isSimulation :
    forall {State1 State2 Label} {lts1 : LTS State1 Label} {lts2 : LTS State2 Label}
    {r : State1 -> State2 -> Prop},
    IsBisimulation lts1 lts2 r -> IsSimulation lts1 lts2 r
```

```
ProvenTheorem IsBisimulation.isSimulation_iff :
    forall {State1 State2 Label} {lts1 : LTS State1 Label} {lts2 : LTS State2 Label}
    {r : State1 -> State2 -> Prop},
    IsBisimulation lts1 lts2 r <-> (IsSimulation lts1 lts2 r /\ IsSimulation lts2 lts1 (flip r))
```

```
ProvenTheorem HomBisimilarity.symm_simulation :
    forall {State Label} {lts : LTS State Label},
    HomBisimilarity lts =
      fun s1 s2 => exists r, r s1 s2 /\ Std.Symm r /\ IsHomSimulation lts r
```

### EQUIVALENCE (weak bisimulation)

```
ProvenTheorem isWeakBisimulation_iff_isSWBisimulation :
    forall {State1 State2 Label} [HasTau Label]
    {lts1 : LTS State1 Label} {lts2 : LTS State2 Label}
    {r : State1 -> State2 -> Prop},
    IsWeakBisimulation lts1 lts2 r <-> IsSWBisimulation lts1 lts2 r
```

```
ProvenTheorem IsWeakBisimulation.isSwBisimulation :
    forall {State1 State2 Label} [HasTau Label]
    {lts1 : LTS State1 Label} {lts2 : LTS State2 Label}
    {r : State1 -> State2 -> Prop},
    IsWeakBisimulation lts1 lts2 r -> IsSWBisimulation lts1 lts2 r
```

```
ProvenTheorem IsSWBisimulation.isWeakBisimulation :
    forall {State1 State2 Label} [HasTau Label]
    {lts1 : LTS State1 Label} {lts2 : LTS State2 Label}
    {r : State1 -> State2 -> Prop},
    IsSWBisimulation lts1 lts2 r -> IsWeakBisimulation lts1 lts2 r
```

```
ProvenTheorem WeakBisimilarity.weakBisim_eq_swBisim :
    forall {State1 State2 Label} [HasTau Label]
    (lts1 : LTS State1 Label) (lts2 : LTS State2 Label),
    WeakBisimilarity lts1 lts2 =
      fun s1 s2 => exists r : State1 -> State2 -> Prop, r s1 s2 /\ IsSWBisimulation lts1 lts2 r
```

### EQUIVALENCE (weak bisimilarity is an equivalence)

```
ProvenTheorem HomWeakBisimilarity.refl :
    forall {State Label} [HasTau Label] {lts : LTS State Label} (s : State),
    s ≈[lts] s
```

```
ProvenTheorem IsWeakBisimulation.inv :
    forall {State1 State2 Label} [HasTau Label]
    {lts1 : LTS State1 Label} {lts2 : LTS State2 Label}
    (r : State1 -> State2 -> Prop),
    IsWeakBisimulation lts1 lts2 r -> IsWeakBisimulation lts2 lts1 (flip r)
```

```
ProvenTheorem WeakBisimilarity.symm :
    forall {State1 State2 Label} [HasTau Label]
    {lts1 : LTS State1 Label} {lts2 : LTS State2 Label} {s1 : State1} {s2 : State2},
    s1 ≈[lts1,lts2] s2 -> s2 ≈[lts2,lts1] s1
```

```
ProvenTheorem IsWeakBisimulation.comp :
    forall {State1 State2 State3 Label} [HasTau Label]
    {lts1 : LTS State1 Label} {lts2 : LTS State2 Label} {lts3 : LTS State3 Label}
    {r1 : State1 -> State2 -> Prop} {r2 : State2 -> State3 -> Prop},
    IsWeakBisimulation lts1 lts2 r1 -> IsWeakBisimulation lts2 lts3 r2 ->
    IsWeakBisimulation lts1 lts3 (Relation.Comp r1 r2)
```

```
ProvenTheorem IsSWBisimulation.comp :
    forall {State1 State2 State3 Label} [HasTau Label]
    {lts1 : LTS State1 Label} {lts2 : LTS State2 Label} {lts3 : LTS State3 Label}
    {r1 : State1 -> State2 -> Prop} {r2 : State2 -> State3 -> Prop},
    IsSWBisimulation lts1 lts2 r1 -> IsSWBisimulation lts2 lts3 r2 ->
    IsSWBisimulation lts1 lts3 (Relation.Comp r1 r2)
```

```
ProvenTheorem WeakBisimilarity.trans :
    forall {State1 State2 State3 Label} [HasTau Label]
    {lts1 : LTS State1 Label} {lts2 : LTS State2 Label} {lts3 : LTS State3 Label}
    {s1 : State1} {s2 : State2} {s3 : State3},
    s1 ≈[lts1,lts2] s2 -> s2 ≈[lts2,lts3] s3 -> s1 ≈[lts1,lts3] s3
```

```
ProvenTheorem HomWeakBisimilarity.eqv :
    forall {State Label} [HasTau Label] {lts : LTS State Label},
    Equivalence (HomWeakBisimilarity lts)
```

### STRUCTURAL (sw-bisimulation internal transition helpers)

```
ProvenTheorem IsSWBisimulation.follow_internal_fst :
    forall {State1 State2 Label} [HasTau Label]
    {lts1 : LTS State1 Label} {lts2 : LTS State2 Label}
    {r : State1 -> State2 -> Prop} {s1 : State1} {s2 : State2} {s1' : State1},
    IsSWBisimulation lts1 lts2 r -> r s1 s2 -> lts1.tauSTr s1 s1' ->
    exists s2', lts2.tauSTr s2 s2' /\ r s1' s2'
```

```
ProvenTheorem IsSWBisimulation.follow_internal_snd :
    forall {State1 State2 Label} [HasTau Label]
    {lts1 : LTS State1 Label} {lts2 : LTS State2 Label}
    {r : State1 -> State2 -> Prop} {s1 : State1} {s2 : State2} {s2' : State2},
    IsSWBisimulation lts1 lts2 r -> r s1 s2 -> lts2.tauSTr s2 s2' ->
    exists s1', lts1.tauSTr s1 s1' /\ r s1' s2'
```

## Dependencies

- `Cslib.Foundations.Data.Relation`
- `Cslib.Foundations.Semantics.LTS.HasTau`
- `Cslib.Foundations.Semantics.LTS.Simulation`
- `Cslib.Foundations.Semantics.LTS.TraceEq`

## Statistics

- **Definitions**: 11 (IsBisimulation, IsHomBisimulation, Bisimilarity, HomBisimilarity, UpToHomBisimilarity, IsBisimulationUpTo, IsWeakBisimulation, IsHomWeakBisimulation, WeakBisimilarity, HomWeakBisimilarity, IsSWBisimulation)
- **Theorems**: 38
  - Strong bisimulation: 24 (structural helpers 2, closure 4, equivalence 4, largest/gfp 3, up-to 1, trace mimicking 1, trace equivalence 7, simulation 3)
  - Weak bisimulation: 12 (sw-bisim characterization 4, equivalence 7, internal-transition helpers 2)
  - Counterexamples: 2 (traceEq_not_bisim, bisimilarity_neq_traceEq)
- **Instances**: 4 (IsEquiv, Trans, SemilatticeSup, BoundedOrder)
- **Lines**: 1023
