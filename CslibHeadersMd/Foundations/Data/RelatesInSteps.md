# Cslib.Foundations.Data.RelatesInSteps

## Module Summary

Defines `RelatesInSteps r a b n` (chain of exactly `n` steps) and `RelatesWithinSteps r a b n` (at most `n` steps). Provides head/tail decomposition, transitivity, homomorphism preservation, and step-counting bounds.

## Vocabulary

| Name | Kind | Description |
|------|------|-------------|
| `Relation.RelatesInSteps` | inductive | `a` relates to `b` in exactly `n` steps of `r` |
| `Relation.RelatesWithinSteps` | def | `a` relates to `b` in at most `n` steps of `r` |

## Theorems

### PUBLIC

| # | Name | Signature |
|---|------|-----------|
| 1 | `RelatesInSteps.reflTransGen` | `theorem RelatesInSteps.reflTransGen (h : RelatesInSteps r a b n) : ReflTransGen r a b` |
| 2 | `ReflTransGen.relatesInSteps` | `theorem ReflTransGen.relatesInSteps (h : ReflTransGen r a b) : exists n, RelatesInSteps r a b n` |
| 3 | `RelatesInSteps.single` | `lemma RelatesInSteps.single {a b : alpha} (h : r a b) : RelatesInSteps r a b 1` |
| 4 | `RelatesInSteps.head` | `theorem RelatesInSteps.head (t t' t'' : alpha) (n : Nat) (h1 : r t t') (h2 : RelatesInSteps r t' t'' n) : RelatesInSteps r t t'' (n+1)` |
| 5 | `RelatesInSteps.head_induction_on` | `theorem RelatesInSteps.head_induction_on {motive : forall (a : alpha) (n : Nat), RelatesInSteps r a b n -> Prop} ... : motive a n h` |
| 6 | `RelatesInSteps.zero` | `lemma RelatesInSteps.zero {a b : alpha} (h : RelatesInSteps r a b 0) : a = b` |
| 7 | `RelatesInSteps.zero_iff` | `lemma RelatesInSteps.zero_iff {a b : alpha} : RelatesInSteps r a b 0 <-> a = b` |
| 8 | `RelatesInSteps.trans` | `lemma RelatesInSteps.trans {a b c : alpha} {n m : Nat} (h1 : RelatesInSteps r a b n) (h2 : RelatesInSteps r b c m) : RelatesInSteps r a c (n + m)` |
| 9 | `RelatesInSteps.succ` | `lemma RelatesInSteps.succ {n : Nat} (h : RelatesInSteps r a b (n + 1)) : exists t', RelatesInSteps r a t' n and r t' b` |
| 10 | `RelatesInSteps.succ_iff` | `lemma RelatesInSteps.succ_iff {a b : alpha} {n : Nat} : RelatesInSteps r a b (n + 1) <-> exists t', RelatesInSteps r a t' n and r t' b` |
| 11 | `RelatesInSteps.succ'` | `lemma RelatesInSteps.succ' {a b : alpha} : forall {n : Nat}, RelatesInSteps r a b (n + 1) -> exists t', r a t' and RelatesInSteps r t' b n` |
| 12 | `RelatesInSteps.succ'_iff` | `lemma RelatesInSteps.succ'_iff {a b : alpha} {n : Nat} : RelatesInSteps r a b (n + 1) <-> exists t', r a t' and RelatesInSteps r t' b n` |
| 13 | `RelatesInSteps.apply_le_apply_add` | `lemma RelatesInSteps.apply_le_apply_add {a b : alpha} {m : Nat} (hevals : RelatesInSteps r a b m) (h : alpha -> Nat) (h_step : forall a b, r a b -> h b <= h a + 1) : h b <= h a + m` |
| 14 | `RelatesInSteps.map` | `lemma RelatesInSteps.map (g : alpha -> alpha') (hg : forall a b, r a b -> r' (g a) (g b)) {a b : alpha} {n : Nat} (h : RelatesInSteps r a b n) : RelatesInSteps r' (g a) (g b) n` |
| 15 | `RelatesWithinSteps.of_relatesInSteps` | `lemma RelatesWithinSteps.of_relatesInSteps {a b : alpha} {n : Nat} (h : RelatesInSteps r a b n) : RelatesWithinSteps r a b n` |
| 16 | `RelatesWithinSteps.refl` | `lemma RelatesWithinSteps.refl (a : alpha) : RelatesWithinSteps r a a 0` |
| 17 | `RelatesWithinSteps.single` | `lemma RelatesWithinSteps.single {a b : alpha} (h : r a b) : RelatesWithinSteps r a b 1` |
| 18 | `RelatesWithinSteps.zero` | `lemma RelatesWithinSteps.zero {a b : alpha} (h : RelatesWithinSteps r a b 0) : a = b` |
| 19 | `RelatesWithinSteps.zero_iff` | `lemma RelatesWithinSteps.zero_iff {a b : alpha} : RelatesWithinSteps r a b 0 <-> a = b` |
| 20 | `RelatesWithinSteps.trans` | `lemma RelatesWithinSteps.trans {a b c : alpha} {n1 n2 : Nat} (h1 : RelatesWithinSteps r a b n1) (h2 : RelatesWithinSteps r b c n2) : RelatesWithinSteps r a c (n1 + n2)` |
| 21 | `RelatesWithinSteps.of_le` | `lemma RelatesWithinSteps.of_le {a b : alpha} {n1 n2 : Nat} (h : RelatesWithinSteps r a b n1) (hn : n1 <= n2) : RelatesWithinSteps r a b n2` |
| 22 | `RelatesWithinSteps.apply_le_apply_add` | `lemma RelatesWithinSteps.apply_le_apply_add {a b : alpha} {m : Nat} (hevals : RelatesWithinSteps r a b m) (h : alpha -> Nat) (h_step : forall a b, r a b -> h b <= h a + 1) : h b <= h a + m` |
| 23 | `RelatesWithinSteps.map` | `lemma RelatesWithinSteps.map (g : alpha -> alpha') (hg : forall a b, r a b -> r' (g a) (g b)) {a b : alpha} {n : Nat} (h : RelatesWithinSteps r a b n) : RelatesWithinSteps r' (g a) (g b) n` |

### INTERNAL

None.

## Counts

- **PUBLIC**: 23
- **INTERNAL**: 0
