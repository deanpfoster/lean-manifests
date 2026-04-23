# Cslib.Foundations.Data.OmegaSequence.Flatten

## Module Summary

Defines `flatten` for omega-sequences of lists and `toSegs` for segmenting an omega-sequence by a strictly monotonic index function. Proves round-trip properties: flattening segments recovers the original sequence.

## Vocabulary

| Name | Kind | Description |
|------|------|-------------|
| `omegaSequence.cumLen` | def | Cumulative length function for an omega-sequence of lists |
| `omegaSequence.flatten` | def (noncomputable) | Concatenate an omega-sequence of nonempty lists into one omega-sequence |
| `omegaSequence.toSegs` | def | Segment an omega-sequence by a function `f`, producing lists `extract (f n) (f (n+1))` |

## Theorems

### PUBLIC

| # | Name | Signature |
|---|------|-----------|
| 1 | `cumLen_zero` | `theorem cumLen_zero {ls : omegaSequence (List alpha)} : ls.cumLen 0 = 0` |
| 2 | `cumLen_succ` | `theorem cumLen_succ (ls : omegaSequence (List alpha)) (k : Nat) : ls.cumLen (k + 1) = ls.cumLen k + (ls k).length` |
| 3 | `cumLen_strictMono` | `theorem cumLen_strictMono {ls : omegaSequence (List alpha)} (h_ls : forall k, (ls k).length > 0) : StrictMono ls.cumLen` |
| 4 | `cons_flatten` | `theorem cons_flatten [Inhabited alpha] {ls : omegaSequence (List alpha)} (h_ls : forall k, (ls k).length > 0) : ls.head ++omega ls.tail.flatten = ls.flatten` |
| 5 | `append_flatten` | `theorem append_flatten [Inhabited alpha] {ls : omegaSequence (List alpha)} (h_ls : forall k, (ls k).length > 0) (n : Nat) : (ls.take n).flatten ++omega (ls.drop n).flatten = ls.flatten` |
| 6 | `length_flatten_take` | `theorem length_flatten_take {ls : omegaSequence (List alpha)} (n : Nat) : (ls.take n).flatten.length = ls.cumLen n` |
| 7 | `flatten_take` | `theorem flatten_take [Inhabited alpha] {ls : omegaSequence (List alpha)} (h_ls : forall k, (ls k).length > 0) (n : Nat) : (ls.take n).flatten = ls.flatten.take (ls.cumLen n)` |
| 8 | `flatten_drop` | `theorem flatten_drop [Inhabited alpha] {ls : omegaSequence (List alpha)} (h_ls : forall k, (ls k).length > 0) (n : Nat) : (ls.drop n).flatten = ls.flatten.drop (ls.cumLen n)` |
| 9 | `extract_flatten` | `theorem extract_flatten [Inhabited alpha] {ls : omegaSequence (List alpha)} (h_ls : forall k, (ls k).length > 0) (n : Nat) : ls.flatten.extract (ls.cumLen n) (ls.cumLen (n + 1)) = ls n` |
| 10 | `segment_toSegs_cumLen` | `theorem segment_toSegs_cumLen {f : Nat -> Nat} (hm : StrictMono f) (h0 : f 0 = 0) (s : omegaSequence alpha) : (s.toSegs f).cumLen = f` |
| 11 | `strictMono_flatten` | `theorem strictMono_flatten [Inhabited alpha] {f : Nat -> Nat} (hm : StrictMono f) (h0 : f 0 = 0) (s : omegaSequence alpha) : (s.toSegs f).flatten = s` |

### INTERNAL

| # | Name | Signature |
|---|------|-----------|
| 1 | `cumLen_one_add_drop` | `theorem cumLen_one_add_drop (ls : omegaSequence (List alpha)) (k : Nat) : ls.cumLen (1 + k) = (ls 0).length + (ls.drop 1).cumLen k` |
| 2 | `cumLen_segment_zero` | `theorem cumLen_segment_zero {ls : omegaSequence (List alpha)} (h_ls : forall k, (ls k).length > 0) (n : Nat) (h_n : n < (ls 0).length) : segment ls.cumLen n = 0` |
| 3 | `cumLen_segment_one_add` | `theorem cumLen_segment_one_add {ls : omegaSequence (List alpha)} (h_ls : forall k, (ls k).length > 0) (n : Nat) (h_n : (ls 0).length <= n) : segment ls.cumLen n = 1 + segment (ls.drop 1).cumLen (n - (ls 0).length)` |
| 4 | `flatten_def` | `theorem flatten_def [Inhabited alpha] (ls : omegaSequence (List alpha)) (n : Nat) : flatten ls n = (ls (segment ls.cumLen n))[n - ls.cumLen (segment ls.cumLen n)]!` |
| 5 | `flatten_take_drop` | `theorem flatten_take_drop [Inhabited alpha] {ls : omegaSequence (List alpha)} (h_ls : forall k, (ls k).length > 0) (n : Nat) : (ls.take n).flatten = ls.flatten.take (ls.cumLen n) and (ls.drop n).flatten = ls.flatten.drop (ls.cumLen n)` |
| 6 | `toSegs_def` | `theorem toSegs_def (s : omegaSequence alpha) (f : Nat -> Nat) (n : Nat) : s.toSegs f n = s.extract (f n) (f (n + 1))` |

## Counts

- **PUBLIC**: 11
- **INTERNAL**: 6
