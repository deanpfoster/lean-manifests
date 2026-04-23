import CslibHeaders.Basic
import Cslib.Foundations.Data.RelatesInSteps

/-! # RelatesInSteps and RelatesWithinSteps

  ## Vocabulary
  - `Relation.RelatesInSteps r a b n` — `a` relates to `b` in exactly `n` steps of `r`
  - `Relation.RelatesWithinSteps r a b n` — `a` relates to `b` in at most `n` steps of `r`
-/

open Relation

-- ════════════════════════════════════════════
-- RelatesInSteps
-- ════════════════════════════════════════════

ExternalTheorem relatesInSteps_reflTransGen
  := @Relation.RelatesInSteps.reflTransGen
  : ∀ {α : Type u_1} {r : α → α → Prop} {a b : α} {n : ℕ},
    RelatesInSteps r a b n → ReflTransGen r a b

ExternalTheorem reflTransGen_relatesInSteps
  := @Relation.ReflTransGen.relatesInSteps
  : ∀ {α : Type u_1} {r : α → α → Prop} {a b : α},
    ReflTransGen r a b → ∃ n, RelatesInSteps r a b n

ExternalTheorem relatesInSteps_single
  := @Relation.RelatesInSteps.single
  : ∀ {α : Type u_1} {r : α → α → Prop} {a b : α},
    r a b → RelatesInSteps r a b 1

ExternalTheorem relatesInSteps_zero_iff
  := @Relation.RelatesInSteps.zero_iff
  : ∀ {α : Type u_1} {r : α → α → Prop} {a b : α},
    RelatesInSteps r a b 0 ↔ a = b

ExternalTheorem relatesInSteps_trans
  := @Relation.RelatesInSteps.trans
  : ∀ {α : Type u_1} {r : α → α → Prop} {a b c : α} {n m : ℕ},
    RelatesInSteps r a b n → RelatesInSteps r b c m → RelatesInSteps r a c (n + m)

ExternalTheorem relatesInSteps_succ_iff
  := @Relation.RelatesInSteps.succ_iff
  : ∀ {α : Type u_1} {r : α → α → Prop} {a b : α} {n : ℕ},
    RelatesInSteps r a b (n + 1) ↔ ∃ t', RelatesInSteps r a t' n ∧ r t' b

ExternalTheorem relatesInSteps_map
  := @Relation.RelatesInSteps.map
  : ∀ {α α' : Type u_1} {r : α → α → Prop} {r' : α' → α' → Prop}
    (g : α → α') (hg : ∀ a b, r a b → r' (g a) (g b))
    {a b : α} {n : ℕ}, RelatesInSteps r a b n → RelatesInSteps r' (g a) (g b) n

-- ════════════════════════════════════════════
-- RelatesWithinSteps
-- ════════════════════════════════════════════

ExternalTheorem relatesWithinSteps_zero_iff
  := @Relation.RelatesWithinSteps.zero_iff
  : ∀ {α : Type u_1} {r : α → α → Prop} {a b : α},
    RelatesWithinSteps r a b 0 ↔ a = b

ExternalTheorem relatesWithinSteps_trans
  := @Relation.RelatesWithinSteps.trans
  : ∀ {α : Type u_1} {r : α → α → Prop} {a b c : α} {n₁ n₂ : ℕ},
    RelatesWithinSteps r a b n₁ → RelatesWithinSteps r b c n₂ →
    RelatesWithinSteps r a c (n₁ + n₂)

ExternalTheorem relatesWithinSteps_of_le
  := @Relation.RelatesWithinSteps.of_le
  : ∀ {α : Type u_1} {r : α → α → Prop} {a b : α} {n₁ n₂ : ℕ},
    RelatesWithinSteps r a b n₁ → n₁ ≤ n₂ → RelatesWithinSteps r a b n₂

ExternalTheorem relatesWithinSteps_map
  := @Relation.RelatesWithinSteps.map
  : ∀ {α α' : Type u_1} {r : α → α → Prop} {r' : α' → α' → Prop}
    (g : α → α') (hg : ∀ a b, r a b → r' (g a) (g b))
    {a b : α} {n : ℕ}, RelatesWithinSteps r a b n → RelatesWithinSteps r' (g a) (g b) n
