# Cslib.Foundations.Data.Relation

## Module Summary

Comprehensive library on abstract rewriting and relation theory: confluence, Church-Rosser, termination, normal forms, Newman's lemma, commutation, strong confluence, diamond property, and the `reduction_sys` attribute for auto-generating notation. 499 lines.

## Vocabulary

| Name | Kind | Description |
|------|------|-------------|
| `Relation.emptyHRelation` | def | The empty heterogeneous relation (always `False`) |
| `Relation.MJoin` | abbrev | Join of the reflexive-transitive closure |
| `Relation.UpTo` | def | Relation `r` "up to" relation `s`: `Comp s (Comp r s)` |
| `Relation.Diamond` | abbrev | Diamond property: common-origin reductions are joinable |
| `Relation.Confluent` | abbrev | Diamond property on reflexive-transitive closure |
| `Relation.SemiConfluent` | abbrev | Single and multi steps with common origin are multi-joinable |
| `Relation.ChurchRosser` | abbrev | Equivalence implies multi-joinability |
| `Relation.Reducible` | abbrev | Exists a value related to `x` |
| `Relation.Normal` | abbrev | Not reducible |
| `Relation.Normalizable` | abbrev | Reachable normal element exists |
| `Relation.Normalizing` | abbrev | Every element is normalizable |
| `Relation.Terminating` | abbrev | Well-founded inverse of transitive closure |
| `Relation.Convergent` | abbrev | Confluent and terminating |
| `Relation.LocallyConfluent` | abbrev | Common-origin single steps are multi-joinable |
| `Relation.StronglyConfluent` | abbrev | Single steps are reflexive- and multi-joinable |
| `Relation.Commute` | def | Generalization of `Confluent` to two relations |
| `Relation.StronglyCommute` | def | Generalization of `StronglyConfluent` to two relations |
| `Relation.DiamondCommute` | def | Generalization of `Diamond` to two relations |
| `reduction_sys` | attribute | Auto-generate step/multi-step notation for a relation |

## Theorems

### PUBLIC

| # | Name | Signature |
|---|------|-----------|
| 1 | `WellFounded.ofTransGen` | `theorem WellFounded.ofTransGen (trans_wf : WellFounded (Relation.TransGen r)) : WellFounded r` |
| 2 | `WellFounded.iff_transGen` | `theorem WellFounded.iff_transGen : WellFounded (Relation.TransGen r) <-> WellFounded r` |
| 3 | `ReflGen.to_eqvGen` | `theorem ReflGen.to_eqvGen (h : ReflGen r a b) : EqvGen r a b` |
| 4 | `TransGen.to_eqvGen` | `theorem TransGen.to_eqvGen (h : TransGen r a b) : EqvGen r a b` |
| 5 | `ReflTransGen.to_eqvGen` | `theorem ReflTransGen.to_eqvGen (h : ReflTransGen r a b) : EqvGen r a b` |
| 6 | `SymmGen.to_eqvGen` | `theorem SymmGen.to_eqvGen (h : SymmGen r a b) : EqvGen r a b` |
| 7 | `MJoin.refl` | `theorem MJoin.refl (a : alpha) : MJoin r a a` |
| 8 | `MJoin.symm` | `theorem MJoin.symm : Symmetric (MJoin r)` |
| 9 | `MJoin.single` | `theorem MJoin.single (h : ReflTransGen r a b) : MJoin r a b` |
| 10 | `Diamond.extend` | `lemma Diamond.extend (h : Diamond r) : ReflTransGen r a b -> r a c -> Join (ReflTransGen r) b c` |
| 11 | `Diamond.toConfluent` | `theorem Diamond.toConfluent (h : Diamond r) : Confluent r` |
| 12 | `Confluent.toChurchRosser` | `theorem Confluent.toChurchRosser (h : Confluent r) : ChurchRosser r` |
| 13 | `SemiConfluent.toConfluent` | `theorem SemiConfluent.toConfluent (h : SemiConfluent r) : Confluent r` |
| 14 | `SemiConfluent_iff_ChurchRosser` | `theorem SemiConfluent_iff_ChurchRosser : SemiConfluent r <-> ChurchRosser r` |
| 15 | `Confluent_iff_ChurchRosser` | `theorem Confluent_iff_ChurchRosser : Confluent r <-> ChurchRosser r` |
| 16 | `Confluent_iff_SemiConfluent` | `theorem Confluent_iff_SemiConfluent : Confluent r <-> SemiConfluent r` |
| 17 | `Confluent_of_unique_end` | `theorem Confluent_of_unique_end {x : alpha} (h : forall y : alpha, ReflTransGen r y x) : Confluent r` |
| 18 | `Normal_iff` | `theorem Normal_iff (r : alpha -> alpha -> Prop) (x : alpha) : Normal r x <-> forall y, not (r x y)` |
| 19 | `Normal.reflTransGen_eq` | `theorem Normal.reflTransGen_eq (h : Normal r x) (xy : ReflTransGen r x y) : x = y` |
| 20 | `ChurchRosser.normal_eqvGen_reflTransGen` | `theorem ChurchRosser.normal_eqvGen_reflTransGen (cr : ChurchRosser r) (norm : Normal r x) (xy : EqvGen r y x) : ReflTransGen r y x` |
| 21 | `ChurchRosser.normal_eq` | `theorem ChurchRosser.normal_eq (cr : ChurchRosser r) (nx : Normal r x) (ny : Normal r y) (xy : EqvGen r x y) : x = y` |
| 22 | `Confluent.equivalence_join_reflTransGen` | `theorem Confluent.equivalence_join_reflTransGen (h : Confluent r) : Equivalence (Join (ReflTransGen r))` |
| 23 | `Terminating.toTransGen` | `theorem Terminating.toTransGen (ht : Terminating r) : Terminating (TransGen r)` |
| 24 | `Terminating.ofTransGen` | `theorem Terminating.ofTransGen : Terminating (TransGen r) -> Terminating r` |
| 25 | `Terminating.iff_transGen` | `theorem Terminating.iff_transGen : Terminating (TransGen r) <-> Terminating r` |
| 26 | `Terminating.subrelation` | `theorem Terminating.subrelation {r' : alpha -> alpha -> Prop} (hr : Terminating r) (h : Subrelation r' r) : Terminating r'` |
| 27 | `Terminating.isNormalizing` | `theorem Terminating.isNormalizing (h : Terminating r) : Normalizing r` |
| 28 | `Terminating.isConfluent_iff_all_unique_Normal` | `theorem Terminating.isConfluent_iff_all_unique_Normal (ht : Terminating r) : Confluent r <-> forall a : alpha, exists! n : alpha, ReflTransGen r a n and Normal r n` |
| 29 | `Convergent.unique_Normal` | `theorem Convergent.unique_Normal (h : Convergent r) : forall a : alpha, exists! n : alpha, ReflTransGen r a n and Normal r n` |
| 30 | `Confluent.toLocallyConfluent` | `theorem Confluent.toLocallyConfluent (h : Confluent r) : LocallyConfluent r` |
| 31 | `LocallyConfluent.Terminating_toConfluent` | `theorem LocallyConfluent.Terminating_toConfluent (hlc : LocallyConfluent r) (ht : Terminating r) : Confluent r` |
| 32 | `StronglyConfluent.toConfluent` | `theorem StronglyConfluent.toConfluent (h : StronglyConfluent r) : Confluent r` |
| 33 | `Commute.symmetric` | `theorem Commute.symmetric : Symmetric (@Commute alpha)` |
| 34 | `Commute.toConfluent` | `theorem Commute.toConfluent : Commute r r = Confluent r` |
| 35 | `StronglyCommute.toCommute` | `theorem StronglyCommute.toCommute (h : StronglyCommute r1 r2) : Commute r1 r2` |
| 36 | `Commute.join_confluent` | `theorem Commute.join_confluent (c1 : Confluent r1) (c2 : Confluent r2) (comm : Commute r1 r2) : Confluent (r1 sup r2)` |
| 37 | `reflTransGen_mono_closed` | `theorem reflTransGen_mono_closed (h1 : Subrelation r1 r2) (h2 : Subrelation r2 (ReflTransGen r1)) : ReflTransGen r1 = ReflTransGen r2` |
| 38 | `reflTransGen_compRel` | `theorem reflTransGen_compRel : ReflTransGen (SymmGen r) = EqvGen r` |
| 39 | `RightUnique.toConfluent` | `theorem RightUnique.toConfluent (hr : Relator.RightUnique r) : Confluent r` |

### INTERNAL

| # | Name | Signature |
|---|------|-----------|
| 1 | `confluent_equivalents` | `private theorem confluent_equivalents : [ChurchRosser r, SemiConfluent r, Confluent r].TFAE` |
| 2 | `StronglyCommute.extend` | `theorem StronglyCommute.extend (h : StronglyCommute r1 r2) (xy : ReflTransGen r1 x y) (xz : r2 x z) : exists w, ReflGen r2 y w and ReflTransGen r1 z w` |
| 3 | `Commute.join_left` | `lemma Commute.join_left (c1 : Commute r1 r3) (c2 : Commute r2 r3) : Commute (r1 sup r2) r3` |
| 4 | `join_inl` | `theorem join_inl (r1_ab : r1 a b) : (r1 sup r2) a b` |
| 5 | `join_inr` | `theorem join_inr (r2_ab : r2 a b) : (r1 sup r2) a b` |
| 6 | `join_inl_reflTransGen` | `theorem join_inl_reflTransGen (r1_ab : ReflTransGen r1 a b) : ReflTransGen (r1 sup r2) a b` |
| 7 | `join_inr_reflTransGen` | `theorem join_inr_reflTransGen (r2_ab : ReflTransGen r2 a b) : ReflTransGen (r1 sup r2) a b` |
| 8 | `ReflGen.compRel_symm` | `lemma ReflGen.compRel_symm : ReflGen (SymmGen r) a b -> ReflGen (SymmGen r) b a` |

## Counts

- **PUBLIC**: 39
- **INTERNAL**: 8
