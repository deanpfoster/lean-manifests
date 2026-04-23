# Cslib.Foundations.Data.OmegaSequence.Init

## Module Summary

Core lemma library for `omegaSequence`: extensionality, eta, cons/head/tail/drop identities, map/zip lemmas, const/iterate lemmas, list-append operations, take/drop/extract algebra, and the `take_theorem` (equality of omega-sequences from equality of all finite approximations). 524 lines.

## Vocabulary

No new types (uses `omegaSequence` from Defs).

## Theorems

### PUBLIC

| # | Name | Signature |
|---|------|-----------|
| 1 | `omegaSequence.eta` | `theorem omegaSequence.eta (s : omegaSequence alpha) : head s ::omega tail s = s` |
| 2 | `omegaSequence.ext` | `theorem omegaSequence.ext {s1 s2 : omegaSequence alpha} : (forall n, s1 n = s2 n) -> s1 = s2` |
| 3 | `get_fun` | `theorem get_fun (f : Nat -> alpha) (n : Nat) : omegaSequence.mk f n = f n` |
| 4 | `get_zero_cons` | `theorem get_zero_cons (a : alpha) (s : omegaSequence alpha) : (a ::omega s) 0 = a` |
| 5 | `head_cons` | `theorem head_cons (a : alpha) (s : omegaSequence alpha) : head (a ::omega s) = a` |
| 6 | `tail_cons` | `theorem tail_cons (a : alpha) (s : omegaSequence alpha) : tail (a ::omega s) = s` |
| 7 | `get_drop` | `theorem get_drop (n m : Nat) (s : omegaSequence alpha) : (drop m s) n = s (m + n)` |
| 8 | `drop_drop` | `theorem drop_drop (n m : Nat) (s : omegaSequence alpha) : drop n (drop m s) = drop (m + n) s` |
| 9 | `get_tail` | `theorem get_tail {n : Nat} {s : omegaSequence alpha} : s.tail n = s (n + 1)` |
| 10 | `tail_drop'` | `theorem tail_drop' {i : Nat} {s : omegaSequence alpha} : tail (drop i s) = s.drop (i + 1)` |
| 11 | `drop_tail'` | `theorem drop_tail' {i : Nat} {s : omegaSequence alpha} : drop i (tail s) = s.drop (i + 1)` |
| 12 | `get_succ_cons` | `theorem get_succ_cons (n : Nat) (s : omegaSequence alpha) (x : alpha) : (x ::omega s) n.succ = s n` |
| 13 | `cons_injective2` | `theorem cons_injective2 : Function.Injective2 (cons : alpha -> omegaSequence alpha -> omegaSequence alpha)` |
| 14 | `get_map` | `theorem get_map (n : Nat) (s : omegaSequence alpha) : (map f s) n = f (s n)` |
| 15 | `head_map` | `theorem head_map (s : omegaSequence alpha) : head (map f s) = f (head s)` |
| 16 | `map_id` | `theorem map_id (s : omegaSequence alpha) : map id s = s` |
| 17 | `map_map` | `theorem map_map (g : beta -> delta) (f : alpha -> beta) (s : omegaSequence alpha) : map g (map f s) = map (g comp f) s` |
| 18 | `get_zip` | `theorem get_zip (n : Nat) (s1 : omegaSequence alpha) (s2 : omegaSequence beta) : (zip f s1 s2) n = f (s1 n) (s2 n)` |
| 19 | `tail_const` | `theorem tail_const (a : alpha) : tail (const a) = const a` |
| 20 | `map_const` | `theorem map_const (f : alpha -> beta) (a : alpha) : map f (const a) = const (f a)` |
| 21 | `get_const` | `theorem get_const (n : Nat) (a : alpha) : (const a) n = a` |
| 22 | `drop_const` | `theorem drop_const (n : Nat) (a : alpha) : drop n (const a) = const a` |
| 23 | `head_iterate` | `theorem head_iterate (f : alpha -> alpha) (a : alpha) : head (iterate f a) = a` |
| 24 | `iterate_id` | `theorem iterate_id (a : alpha) : iterate id a = const a` |
| 25 | `nil_append_omegaSequence` | `theorem nil_append_omegaSequence (s : omegaSequence alpha) : appendomegaSequence [] s = s` |
| 26 | `append_append_omegaSequence` | `theorem append_append_omegaSequence : forall (l1 l2 : List alpha) (s : omegaSequence alpha), l1 ++ l2 ++omega s = l1 ++omega (l2 ++omega s)` |
| 27 | `get_append_right` | `lemma get_append_right : (x ++omega a) (x.length + n) = a n` |
| 28 | `append_right_inj` | `lemma append_right_inj : x ++omega a = x ++omega b <-> a = b` |
| 29 | `drop_zero` | `theorem drop_zero {s : omegaSequence alpha} : s.drop 0 = s` |
| 30 | `take_zero` | `theorem take_zero (s : omegaSequence alpha) : take 0 s = []` |
| 31 | `take_succ_cons` | `theorem take_succ_cons {a : alpha} (n : Nat) (s : omegaSequence alpha) : take (n+1) (a ::omega s) = a :: take n s` |
| 32 | `take_one` | `theorem take_one {xs : omegaSequence alpha} : xs.take 1 = [xs 0]` |
| 33 | `length_take` | `theorem length_take (n : Nat) (s : omegaSequence alpha) : (take n s).length = n` |
| 34 | `take_take` | `theorem take_take {s : omegaSequence alpha} : forall {m n}, (s.take n).take m = s.take (min n m)` |
| 35 | `concat_take_get` | `theorem concat_take_get {n : Nat} {s : omegaSequence alpha} : s.take n ++ [s n] = s.take (n + 1)` |
| 36 | `dropLast_take` | `theorem dropLast_take {n : Nat} {xs : omegaSequence alpha} : (omegaSequence.take n xs).dropLast = omegaSequence.take (n-1) xs` |
| 37 | `append_take_drop` | `theorem append_take_drop (n : Nat) (s : omegaSequence alpha) : appendomegaSequence (take n s) (drop n s) = s` |
| 38 | `take_prefix` | `lemma take_prefix : a.take m <+: a.take n <-> m <= n` |
| 39 | `take_theorem` | `theorem take_theorem (s1 s2 : omegaSequence alpha) (h : forall n : Nat, take n s1 = take n s2) : s1 = s2` |
| 40 | `extract_eq_nil_iff` | `theorem extract_eq_nil_iff {xs : omegaSequence alpha} {m n : Nat} : xs.extract m n = [] <-> m >= n` |
| 41 | `get_extract` | `theorem get_extract {xs : omegaSequence alpha} {m n k : Nat} (h : k < n - m) : (xs.extract m n)[k]'(...) = xs (m + k)` |
| 42 | `append_extract_extract` | `theorem append_extract_extract {xs : omegaSequence alpha} {k m n : Nat} (h_km : k <= m) (h_mn : m <= n) : (xs.extract k m) ++ (xs.extract m n) = xs.extract k n` |
| 43 | `extract_succ_right` | `theorem extract_succ_right {xs : omegaSequence alpha} {m n : Nat} (h_mn : m <= n) : xs.extract m (n + 1) = xs.extract m n ++ [xs n]` |
| 44 | `extract_lu_extract_lu` | `theorem extract_lu_extract_lu {xs : omegaSequence alpha} {m n i j : Nat} (h : j <= n - m) : (xs.extract m n).extract i j = xs.extract (m + i) (m + j)` |
| 45 | `take_extract` | `theorem take_extract {xs : omegaSequence alpha} {m n k : Nat} (h : k <= n - m) : (xs.extract m n).take k = xs.extract m (m + k)` |
| 46 | `drop_extract` | `theorem drop_extract {xs : omegaSequence alpha} {m n k : Nat} (h : k <= n - m) : (xs.extract m n).drop k = xs.extract (m + k) n` |

### INTERNAL

| # | Name | Signature |
|---|------|-----------|
| 1 | `tail_eq_drop` | `theorem tail_eq_drop (s : omegaSequence alpha) : tail s = drop 1 s` |
| 2 | `get_succ` | `theorem get_succ (n : Nat) (s : omegaSequence alpha) : s (succ n) = (tail s) n` |
| 3 | `tail_drop` | `theorem tail_drop (n : Nat) (s : omegaSequence alpha) : tail (drop n s) = drop n (tail s)` |
| 4 | `drop_map` | `theorem drop_map (n : Nat) (s : omegaSequence alpha) : drop n (map f s) = map f (drop n s)` |
| 5 | `tail_map` | `theorem tail_map (s : omegaSequence alpha) : tail (map f s) = map f (tail s)` |
| 6 | `map_eq` | `theorem map_eq (s : omegaSequence alpha) : map f s = f (head s) ::omega map f (tail s)` |
| 7 | `map_cons` | `theorem map_cons (a : alpha) (s : omegaSequence alpha) : map f (a ::omega s) = f a ::omega map f s` |
| 8 | `get_iterate` | `theorem get_iterate (f : alpha -> alpha) (a : alpha) (n : Nat) : iterate f a n = f^[n] a` |
| 9 | `take_succ` | `theorem take_succ (n : Nat) (s : omegaSequence alpha) : take (succ n) s = head s :: take n (tail s)` |
| 10 | `take_succ'` | `theorem take_succ' {s : omegaSequence alpha} : forall n, s.take (n+1) = s.take n ++ [s n]` |
| 11 | `get_append_left` | `lemma get_append_left (h : n < x.length) : (x ++omega a) n = x[n]` |
| 12 | `getElem?_take` | `theorem getElem?_take {s : omegaSequence alpha} : forall {k n}, k < n -> (s.take n)[k]? = s k` |

## Counts

- **PUBLIC**: 46
- **INTERNAL**: 12
