# Cslib.Foundations.Data.OmegaSequence.Temporal

## Module Summary

Temporal reasoning primitives over omega-sequences: `Step` (next-state), `LeadsTo` (eventual reachability), and combinators for composing temporal properties with "frequently" (infinitely often) predicates.

## Vocabulary

| Name | Kind | Description |
|------|------|-------------|
| `omegaSequence.Step` | def | `Step xs p q` means `p` at position `k` implies `q` at position `k+1` |
| `omegaSequence.LeadsTo` | def | `LeadsTo xs p q` means `p` at `k` implies `q` at some `k' >= k` |

## Theorems

### PUBLIC

| # | Name | Signature |
|---|------|-----------|
| 1 | `step_leadsTo` | `theorem step_leadsTo {p q : Set alpha} (h : xs.Step p q) : xs.LeadsTo p q` |
| 2 | `leadsTo_trans` | `theorem leadsTo_trans {p q r : Set alpha} (h1 : xs.LeadsTo p q) (h2 : xs.LeadsTo q r) : xs.LeadsTo p r` |
| 3 | `leadsTo_cases_or` | `theorem leadsTo_cases_or {p q r s : Set alpha} (h1 : xs.LeadsTo (p inter q) r) (h2 : xs.LeadsTo (p inter q^c) s) : xs.LeadsTo p (r union s)` |
| 4 | `until_frequently_not_leadsTo` | `theorem until_frequently_not_leadsTo {p q : Set alpha} (h1 : xs.Step (p inter q^c) p) (h2 : exists^f k in atTop, xs k not-in p) : xs.LeadsTo p q` |
| 5 | `until_frequently_leadsTo_and` | `theorem until_frequently_leadsTo_and {p q : Set alpha} (h1 : xs.Step (p inter q^c) p) (h2 : exists^f k in atTop, xs k in q) : xs.LeadsTo p (p inter q)` |
| 6 | `frequently_leadsTo_frequently` | `theorem frequently_leadsTo_frequently {p q : Set alpha} (h1 : exists^f k in atTop, xs k in p) (h2 : xs.LeadsTo p q) : exists^f k in atTop, xs k in q` |
| 7 | `drop_frequently_iff_frequently` | `theorem drop_frequently_iff_frequently {p : Set alpha} (n : Nat) : (exists^f k in atTop, (xs.drop n) k in p) <-> (exists^f k in atTop, xs k in p)` |

### INTERNAL

None.

## Counts

- **PUBLIC**: 7
- **INTERNAL**: 0
