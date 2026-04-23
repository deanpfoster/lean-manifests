# Cslib.Foundations.Combinatorics.InfiniteGraphRamsey

## Module Summary

Ramsey theorem for infinite graphs: if edges of an infinite complete graph are finitely colored, there exists a monochromatic infinite clique. Also proves an infinite pigeonhole principle.

## Vocabulary

| Name | Kind | Description |
|------|------|-------------|
| `InfVSet` | structure (private) | A set of vertices with a proof of infiniteness |
| `Selection` | structure (private) | An `InfVSet` plus a distinguished vertex and a color |
| `GoodSelection` | def (private) | Predicate: vertex is outside the infinite set, all edges to set share a color |

## Theorems

### PUBLIC

| # | Name | Signature |
|---|------|-----------|
| 1 | `infinite_pigeonhole_principle` | `theorem infinite_pigeonhole_principle {X Y : Type*} [Finite Y] (f : X → Y) {s : Set X} (h_inf : s.Infinite) : ∃ y, ∃ t, t.Infinite ∧ t ⊆ s ∧ ∀ x ∈ t, f x = y` |
| 2 | `infinite_graph_ramsey` | `theorem infinite_graph_ramsey : ∃ c : Color, ∃ s : Set Vertex, s.Infinite ∧ ∀ e : Finset Vertex, e.card = 2 → ↑e ⊆ s → color e = c` |

### INTERNAL

| # | Name | Signature |
|---|------|-----------|
| 1 | `goodSelection_exists` | `private lemma goodSelection_exists (ivs : InfVSet Vertex) : ∃ S : Selection Vertex Color, GoodSelection color ivs S` |
| 2 | `goodSelection_seq` | `private noncomputable def goodSelection_seq : ℕ → Selection Vertex Color` |
| 3 | `goodSelection_seq_prop` | `private lemma goodSelection_seq_prop (n : ℕ) : ∃ ivs : InfVSet Vertex, GoodSelection color ivs (goodSelection_seq color n) ∧ (ivs.set = ⋂ m < n, (goodSelection_seq color m).vs.set)` |
| 4 | `good_selections_exist` | `private lemma good_selections_exist : ∃ vs : ℕ → Set Vertex, ∃ v : ℕ → Vertex, ∃ c : ℕ → Color, ∀ n, vs n ⊆ (⋂ m < n, vs m) ∧ v n ∈ (⋂ m < n, vs m) \ (vs n) ∧ ∀ u ∈ vs n, color {v n, u} = c n` |

## Counts

- **PUBLIC**: 2
- **INTERNAL**: 4
