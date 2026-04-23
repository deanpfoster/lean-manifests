import CslibHeaders.Basic
import Cslib.Foundations.Combinatorics.InfiniteGraphRamsey

/-! # Ramsey theorem for infinite graphs

  ## Vocabulary
  - `Cslib.infinite_pigeonhole_principle` — infinite pigeonhole: a function from an infinite set
    to a finite type has an infinite monochromatic subset
  - `Cslib.infinite_graph_ramsey` — if edges of an infinite complete graph are finitely colored,
    there is a color and an infinite monochromatic clique
-/

open Cslib

set_option linter.style.longLine false

ExternalTheorem infinite_pigeonhole_principle
  := @Cslib.infinite_pigeonhole_principle
  : ∀ {X : Type u_1} {Y : Type u_2} [inst : Finite Y] (f : X → Y) {s : Set X},
    s.Infinite → ∃ y, ∃ t, t.Infinite ∧ t ⊆ s ∧ ∀ x ∈ t, f x = y

ExternalTheorem infinite_graph_ramsey
  := @Cslib.infinite_graph_ramsey
  : ∀ {Vertex : Type u_1} {Color : Type u_2} [inst : Finite Color] (color : Finset Vertex → Color) [inst_1 : Infinite Vertex],
    ∃ c, ∃ s : Set Vertex, s.Infinite ∧ ∀ e, e.card = 2 → ↑e ⊆ s → color e = c
