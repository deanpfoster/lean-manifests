# Cslib.Foundations.Semantics.LTS.Bisimulation

## Module Summary

Comprehensive theory of bisimulation and bisimilarity for LTSs (1023 lines). Defines bisimulation, bisimilarity, bisimulation up-to, weak bisimulation via saturation, and sw-bisimulation. Proves bisimilarity is the largest bisimulation, an equivalence, and relates bisimulation to trace equivalence and simulation. Shows weak bisimulation and sw-bisimulation coincide.

## Vocabulary

| Name | Kind | Description |
|------|------|-------------|
| `IsBisimulation` | def | Relation where related states mimic each other's transitions |
| `IsHomBisimulation` | abbrev | Bisimulation on the same LTS |
| `Bisimilarity` | def | Largest bisimulation: exists a bisimulation relating the states |
| `HomBisimilarity` | abbrev | Bisimilarity on the same LTS |
| `UpToHomBisimilarity` | def | Lifts `r` to homogeneous bisimilarities on its types |
| `IsBisimulationUpTo` | def | Bisimulation up to homogeneous bisimilarity |
| `IsWeakBisimulation` | def | Bisimulation on saturated LTSs |
| `IsHomWeakBisimulation` | abbrev | Weak bisimulation on the same LTS |
| `WeakBisimilarity` | def | Largest weak bisimulation |
| `HomWeakBisimilarity` | abbrev | Weak bisimilarity on the same LTS |
| `IsSWBisimulation` | def | Convenient alternative definition for weak bisimulation (single-transition challenge) |

## Theorems

### PUBLIC

| # | Name | Signature |
|---|------|-----------|
| 1 | `IsBisimulation.follow_fst` | `theorem IsBisimulation.follow_fst (hb : IsBisimulation lts1 lts2 r) (hr : r s1 s2) (htr : lts1.Tr s1 mu s1') : exists s2', lts2.Tr s2 mu s2' and r s1' s2'` |
| 2 | `IsBisimulation.follow_snd` | `theorem IsBisimulation.follow_snd (hb : IsBisimulation lts1 lts2 r) (hr : r s1 s2) (htr : lts2.Tr s2 mu s2') : exists s1', lts1.Tr s1 mu s1' and r s1' s2'` |
| 3 | `HomBisimilarity.refl` | `theorem HomBisimilarity.refl (s : State) : s ~[lts] s` |
| 4 | `IsBisimulation.inv` | `theorem IsBisimulation.inv (h : IsBisimulation lts1 lts2 r) : IsBisimulation lts2 lts1 (flip r)` |
| 5 | `Bisimilarity.symm` | `theorem Bisimilarity.symm {s1 s2 : State} (h : s1 ~[lts1,lts2] s2) : s2 ~[lts2,lts1] s1` |
| 6 | `IsBisimulation.comp` | `theorem IsBisimulation.comp (h1 : IsBisimulation lts1 lts2 r1) (h2 : IsBisimulation lts2 lts3 r2) : IsBisimulation lts1 lts3 (Relation.Comp r1 r2)` |
| 7 | `Bisimilarity.trans` | `theorem Bisimilarity.trans (h1 : s1 ~[lts1,lts2] s2) (h2 : s2 ~[lts2,lts3] s3) : s1 ~[lts1,lts3] s3` |
| 8 | `HomBisimilarity.eqv` | `theorem HomBisimilarity.eqv : Equivalence (HomBisimilarity lts)` |
| 9 | `IsBisimulation.sup` | `theorem IsBisimulation.sup (hrb : IsBisimulation lts1 lts2 r) (hsb : IsBisimulation lts1 lts2 s) : IsBisimulation lts1 lts2 (r sup s)` |
| 10 | `Bisimilarity.is_bisimulation` | `theorem Bisimilarity.is_bisimulation : IsBisimulation lts1 lts2 (Bisimilarity lts1 lts2)` |
| 11 | `Bisimilarity.largest_bisimulation` | `theorem Bisimilarity.largest_bisimulation (h : IsBisimulation lts1 lts2 r) : Subrelation r (Bisimilarity lts1 lts2)` |
| 12 | `Bisimilarity.gfp` | `theorem Bisimilarity.gfp (r : State1 -> State2 -> Prop) (h : IsBisimulation lts1 lts2 r) : (Bisimilarity lts1 lts2) sup r = Bisimilarity lts1 lts2` |
| 13 | `IsBisimulation.bot` | `theorem IsBisimulation.bot : IsBisimulation lts1 lts2 Relation.emptyHRelation` |
| 14 | `IsBisimulationUpTo.is_bisimulation` | `theorem IsBisimulationUpTo.is_bisimulation (h : IsBisimulationUpTo lts1 lts2 r) : IsBisimulation lts1 lts2 (UpToHomBisimilarity lts1 lts2 r)` |
| 15 | `IsBisimulation.bisim_trace` | `theorem IsBisimulation.bisim_trace (hb : IsBisimulation lts1 lts2 r) (hr : r s1 s2) : forall mus s1', lts1.MTr s1 mus s1' -> exists s2', lts2.MTr s2 mus s2' and r s1' s2'` |
| 16 | `IsBisimulation.traceEq` | `theorem IsBisimulation.traceEq (hb : IsBisimulation lts1 lts2 r) (hr : r s1 s2) : s1 ~tr[lts1,lts2] s2` |
| 17 | `Bisimilarity.le_traceEq` | `theorem Bisimilarity.le_traceEq : Bisimilarity lts1 lts2 <= TraceEq lts1 lts2` |
| 18 | `IsBisimulation.traceEq_not_bisim` | `theorem IsBisimulation.traceEq_not_bisim : exists (State : Type) (Label : Type) (lts : LTS State Label), not (IsHomBisimulation lts (HomTraceEq lts))` |
| 19 | `Bisimilarity.bisimilarity_neq_traceEq` | `theorem Bisimilarity.bisimilarity_neq_traceEq : exists (State : Type) (Label : Type) (lts : LTS State Label), HomBisimilarity lts != HomTraceEq lts` |
| 20 | `IsBisimulation.deterministic_traceEq_isBisimulation` | `theorem IsBisimulation.deterministic_traceEq_isBisimulation {lts1 : LTS State1 Label} {lts2 : LTS State2 Label} [lts1.Deterministic] [lts2.Deterministic] : (IsBisimulation lts1 lts2 (TraceEq lts1 lts2))` |
| 21 | `Bisimilarity.deterministic_traceEq_bisim` | `theorem Bisimilarity.deterministic_traceEq_bisim {lts1 : LTS State1 Label} {lts2 : LTS State2 Label} [lts1.Deterministic] [lts2.Deterministic] (h : s1 ~tr[lts1,lts2] s2) : (s1 ~[lts1,lts2] s2)` |
| 22 | `Bisimilarity.deterministic_bisim_eq_traceEq` | `theorem Bisimilarity.deterministic_bisim_eq_traceEq {lts1 : LTS State1 Label} {lts2 : LTS State2 Label} [lts1.Deterministic] [lts2.Deterministic] : Bisimilarity lts1 lts2 = TraceEq lts1 lts2` |
| 23 | `IsBisimulation.isSimulation` | `theorem IsBisimulation.isSimulation : IsBisimulation lts1 lts2 r -> IsSimulation lts1 lts2 r` |
| 24 | `IsBisimulation.isSimulation_iff` | `theorem IsBisimulation.isSimulation_iff : IsBisimulation lts1 lts2 r <-> (IsSimulation lts1 lts2 r and IsSimulation lts2 lts1 (flip r))` |
| 25 | `HomBisimilarity.symm_simulation` | `theorem HomBisimilarity.symm_simulation : HomBisimilarity lts = fun s1 s2 => exists r, r s1 s2 and Std.Symm r and IsHomSimulation lts r` |
| 26 | `isWeakBisimulation_iff_isSWBisimulation` | `theorem isWeakBisimulation_iff_isSWBisimulation [HasTau Label] {lts1 : LTS State1 Label} {lts2 : LTS State2 Label} : IsWeakBisimulation lts1 lts2 r <-> IsSWBisimulation lts1 lts2 r` |
| 27 | `WeakBisimilarity.weakBisim_eq_swBisim` | `theorem WeakBisimilarity.weakBisim_eq_swBisim [HasTau Label] (lts1 : LTS State1 Label) (lts2 : LTS State2 Label) : WeakBisimilarity lts1 lts2 = fun s1 s2 => exists r, r s1 s2 and IsSWBisimulation lts1 lts2 r` |
| 28 | `HomWeakBisimilarity.refl` | `theorem HomWeakBisimilarity.refl [HasTau Label] {lts : LTS State Label} (s : State) : s approx[lts] s` |
| 29 | `IsWeakBisimulation.inv` | `theorem IsWeakBisimulation.inv [HasTau Label] (r : State1 -> State2 -> Prop) (h : IsWeakBisimulation lts1 lts2 r) : IsWeakBisimulation lts2 lts1 (flip r)` |
| 30 | `WeakBisimilarity.symm` | `theorem WeakBisimilarity.symm [HasTau Label] (h : s1 approx[lts1,lts2] s2) : s2 approx[lts2,lts1] s1` |
| 31 | `IsWeakBisimulation.comp` | `theorem IsWeakBisimulation.comp [HasTau Label] (h1 : IsWeakBisimulation lts1 lts2 r1) (h2 : IsWeakBisimulation lts2 lts3 r2) : IsWeakBisimulation lts1 lts3 (Relation.Comp r1 r2)` |
| 32 | `IsSWBisimulation.comp` | `theorem IsSWBisimulation.comp [HasTau Label] (h1 : IsSWBisimulation lts1 lts2 r1) (h2 : IsSWBisimulation lts2 lts3 r2) : IsSWBisimulation lts1 lts3 (Relation.Comp r1 r2)` |
| 33 | `WeakBisimilarity.trans` | `theorem WeakBisimilarity.trans [HasTau Label] (h1 : s1 approx[lts1,lts2] s2) (h2 : s2 approx[lts2,lts3] s3) : s1 approx[lts1,lts3] s3` |
| 34 | `HomWeakBisimilarity.eqv` | `theorem HomWeakBisimilarity.eqv [HasTau Label] {lts : LTS State Label} : Equivalence (HomWeakBisimilarity lts)` |

### INTERNAL

| # | Name | Signature |
|---|------|-----------|
| 1 | `IsSWBisimulation.follow_internal_fst` | `theorem IsSWBisimulation.follow_internal_fst [HasTau Label] (hswb : IsSWBisimulation lts1 lts2 r) (hr : r s1 s2) (hstr : lts1.tauSTr s1 s1') : exists s2', lts2.tauSTr s2 s2' and r s1' s2'` |
| 2 | `IsSWBisimulation.follow_internal_snd` | `theorem IsSWBisimulation.follow_internal_snd [HasTau Label] (hswb : IsSWBisimulation lts1 lts2 r) (hr : r s1 s2) (hstr : lts2.tauSTr s2 s2') : exists s1', lts1.tauSTr s1 s1' and r s1' s2'` |
| 3 | `IsWeakBisimulation.isSwBisimulation` | `theorem IsWeakBisimulation.isSwBisimulation [HasTau Label] (h : IsWeakBisimulation lts1 lts2 r) : IsSWBisimulation lts1 lts2 r` |
| 4 | `IsSWBisimulation.isWeakBisimulation` | `theorem IsSWBisimulation.isWeakBisimulation [HasTau Label] (h : IsSWBisimulation lts1 lts2 r) : IsWeakBisimulation lts1 lts2 r` |

## Counts

- **PUBLIC**: 34
- **INTERNAL**: 4
