# Cslib.Foundations.Data.Nat.Segment

## Module Summary

Defines `Nat.segment f k` for a strictly monotonic `f : Nat -> Nat`: the unique `m` with `f m <= k < f (m+1)`. Proves basic properties, bounds, range-value characterization, and a Galois connection with `f`.

## Vocabulary

| Name | Kind | Description |
|------|------|-------------|
| `Nat.segment` | def (noncomputable) | The `f`-segment of `k` |
| `Nat.segment'` | def (noncomputable) | Helper equal to `segment` after base shift |

## Theorems

### PUBLIC

| # | Name | Signature |
|---|------|-----------|
| 1 | `Nat.strictMono_infinite` | `theorem Nat.strictMono_infinite (hm : StrictMono f) : (range f).Infinite` |
| 2 | `Nat.infinite_strictMono` | `theorem Nat.infinite_strictMono {ns : Set ℕ} (h : ns.Infinite) : ∃ f : ℕ → ℕ, StrictMono f ∧ range f = ns` |
| 3 | `Nat.nth_succ_gap` | `theorem Nat.nth_succ_gap {p : ℕ → Prop} (hf : (setOf p).Infinite) (n : ℕ) : ∀ k < nth p (n + 1) - nth p n, k > 0 → ¬ p (k + nth p n)` |
| 4 | `Nat.nth_of_strictMono` | `theorem Nat.nth_of_strictMono (hm : StrictMono f) (n : ℕ) : f n = nth (· ∈ range f) n` |
| 5 | `Nat.segment_idem` | `theorem Nat.segment_idem (hm : StrictMono f) (k : ℕ) : segment f (f k) = k` |
| 6 | `Nat.segment_pre_zero` | `theorem Nat.segment_pre_zero (hm : StrictMono f) {k : ℕ} (h : k < f 0) : segment f k = 0` |
| 7 | `Nat.segment_zero` | `theorem Nat.segment_zero (hm : StrictMono f) (h0 : f 0 = 0) : segment f 0 = 0` |
| 8 | `Nat.segment_plus_one` | `theorem Nat.segment_plus_one (h0 : f 0 = 0) (k : ℕ) : segment f k + 1 = count (· ∈ range f) (k + 1)` |
| 9 | `Nat.segment_upper_bound` | `theorem Nat.segment_upper_bound (hm : StrictMono f) (h0 : f 0 = 0) (k : ℕ) : k < f (segment f k + 1)` |
| 10 | `Nat.segment_lower_bound` | `theorem Nat.segment_lower_bound (hm : StrictMono f) (h0 : f 0 = 0) (k : ℕ) : f (segment f k) ≤ k` |
| 11 | `Nat.segment_range_val` | `theorem Nat.segment_range_val (hm : StrictMono f) {m k : ℕ} (hl : f m ≤ k) (hu : k < f (m + 1)) : segment f k = m` |
| 12 | `Nat.segment_galois_connection` | `theorem Nat.segment_galois_connection (hm : StrictMono f) (h0 : f 0 = 0) : GaloisConnection f (segment f)` |
| 13 | `Nat.segment'_eq_segment` | `theorem Nat.segment'_eq_segment (hm : StrictMono f) : segment' f = segment f` |
| 14 | `Nat.segment_zero'` | `theorem Nat.segment_zero' (hm : StrictMono f) {k : ℕ} (h : k ≤ f 0) : segment f k = 0` |
| 15 | `Nat.segment_upper_bound'` | `theorem Nat.segment_upper_bound' (hm : StrictMono f) {k : ℕ} (h : f 0 ≤ k) : k < f (segment f k + 1)` |
| 16 | `Nat.segment_lower_bound'` | `theorem Nat.segment_lower_bound' (hm : StrictMono f) {k : ℕ} (h : f 0 ≤ k) : f (segment f k) ≤ k` |

### INTERNAL

| # | Name | Signature |
|---|------|-----------|
| 1 | `Nat.count_notMem_range_pos` | `theorem Nat.count_notMem_range_pos (h0 : f 0 = 0) (n : ℕ) (hn : n ∉ range f) : count (· ∈ range f) n > 0` |
| 2 | `Nat.strictMono_range_gap` | `theorem Nat.strictMono_range_gap (hm : StrictMono f) {m k : ℕ} (hl : f m < k) (hu : k < f (m + 1)) : k ∉ range f` |
| 3 | `Nat.base_zero_shift` | `private lemma base_zero_shift (f : ℕ → ℕ) : (f · - f 0) 0 = 0` |
| 4 | `Nat.base_zero_strictMono` | `theorem Nat.base_zero_strictMono (hm : StrictMono f) : StrictMono (f · - f 0)` |

## Counts

- **PUBLIC**: 16
- **INTERNAL**: 4
