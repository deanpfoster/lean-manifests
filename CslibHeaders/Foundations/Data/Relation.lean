import CslibHeaders.Basic
import Cslib.Foundations.Data.Relation

/-! # Relation: confluence, termination, and rewriting theory

  ## Vocabulary
  - `Relation.ReflGen r`      — reflexive closure of `r`
  - `Relation.TransGen r`     — transitive closure of `r`
  - `Relation.ReflTransGen r` — reflexive-transitive closure of `r`
  - `Relation.SymmGen r`      — symmetric closure of `r`
  - `Relation.EqvGen r`       — equivalence closure of `r`
  - `Relation.Join r b c`     — `∃ a, r b a ∧ r c a` (joinability)
  - `Relation.MJoin r`        — join of reflexive-transitive closure
  - `Relation.UpTo r s`       — relation `r` "up to" relation `s`
  - `Relation.Diamond r`      — all reductions with common origin are joinable
  - `Relation.Confluent r`    — diamond property of `ReflTransGen r`
  - `Relation.SemiConfluent r` — single + multi steps with common origin are multi-joinable
  - `Relation.ChurchRosser r` — equivalence implies multi-joinability
  - `Relation.Reducible r x`  — `∃ y, r x y`
  - `Relation.Normal r x`     — `¬ Reducible r x` (irreducible)
  - `Relation.Normalizable r x` — reachable normal form exists
  - `Relation.Normalizing r`  — every element is normalizable
  - `Relation.Terminating r`  — `WellFounded (fun a b => r b a)`
  - `Relation.Convergent r`   — confluent and terminating
  - `Relation.LocallyConfluent r` — single-step diamond with multi-step join
  - `Relation.StronglyConfluent r` — single steps are refl- and multi-joinable
  - `Relation.Commute r₁ r₂`  — generalization of confluence to two relations
  - `Relation.StronglyCommute r₁ r₂` — generalization of strong confluence
  - `Relation.DiamondCommute r₁ r₂`  — generalization of diamond property

  ## References
  - *Term Rewriting and All That* (Baader & Nipkow, 1998)
-/

open Relation

-- ════════════════════════════════════════════
-- Well-foundedness and transitive closure
-- ════════════════════════════════════════════

ExternalTheorem wf_ofTransGen
  := @WellFounded.ofTransGen
  : ∀ {α : Type u_1} {r : α → α → Prop},
    WellFounded (Relation.TransGen r) → WellFounded r

ExternalTheorem wf_iff_transGen
  := @WellFounded.iff_transGen
  : ∀ {α : Type u_1} {r : α → α → Prop},
    WellFounded (Relation.TransGen r) ↔ WellFounded r

-- ════════════════════════════════════════════
-- Closure conversions to EqvGen
-- ════════════════════════════════════════════

ExternalTheorem reflGen_to_eqvGen
  := @Relation.ReflGen.to_eqvGen
  : ∀ {α : Type u_1} {r : α → α → Prop} {a b : α},
    Relation.ReflGen r a b → Relation.EqvGen r a b

ExternalTheorem transGen_to_eqvGen
  := @Relation.TransGen.to_eqvGen
  : ∀ {α : Type u_1} {r : α → α → Prop} {a b : α},
    Relation.TransGen r a b → Relation.EqvGen r a b

ExternalTheorem reflTransGen_to_eqvGen
  := @Relation.ReflTransGen.to_eqvGen
  : ∀ {α : Type u_1} {r : α → α → Prop} {a b : α},
    Relation.ReflTransGen r a b → Relation.EqvGen r a b

ExternalTheorem symmGen_to_eqvGen
  := @Relation.SymmGen.to_eqvGen
  : ∀ {α : Type u_1} {r : α → α → Prop} {a b : α},
    Relation.SymmGen r a b → Relation.EqvGen r a b

-- ════════════════════════════════════════════
-- MJoin (multi-step joinability)
-- ════════════════════════════════════════════

ExternalTheorem mjoin_refl
  := @Relation.MJoin.refl
  : ∀ {α : Type u_1} {r : α → α → Prop} (a : α),
    Relation.MJoin r a a

ExternalTheorem mjoin_symm
  := @Relation.MJoin.symm
  : ∀ {α : Type u_1} {r : α → α → Prop},
    Symmetric (Relation.MJoin r)

ExternalTheorem mjoin_single
  := @Relation.MJoin.single
  : ∀ {α : Type u_1} {r : α → α → Prop} {a b : α},
    Relation.ReflTransGen r a b → Relation.MJoin r a b

-- ════════════════════════════════════════════
-- Diamond property and confluence
-- ════════════════════════════════════════════

ExternalTheorem diamond_extend
  := @Relation.Diamond.extend
  : ∀ {α : Type u_1} {r : α → α → Prop} {a b c : α},
    Relation.Diamond r →
    Relation.ReflTransGen r a b →
    r a c →
    Relation.Join (Relation.ReflTransGen r) b c

ExternalTheorem diamond_toConfluent
  := @Relation.Diamond.toConfluent
  : ∀ {α : Type u_1} {r : α → α → Prop},
    Relation.Diamond r → Relation.Confluent r

ExternalTheorem confluent_toChurchRosser
  := @Relation.Confluent.toChurchRosser
  : ∀ {α : Type u_1} {r : α → α → Prop},
    Relation.Confluent r → Relation.ChurchRosser r

ExternalTheorem semiconfluent_toConfluent
  := @Relation.SemiConfluent.toConfluent
  : ∀ {α : Type u_1} {r : α → α → Prop},
    Relation.SemiConfluent r → Relation.Confluent r

-- ════════════════════════════════════════════
-- Equivalences among confluence properties
-- ════════════════════════════════════════════

ExternalTheorem semiconfluent_iff_churchRosser
  := @Relation.SemiConfluent_iff_ChurchRosser
  : ∀ {α : Type u_1} {r : α → α → Prop},
    Relation.SemiConfluent r ↔ Relation.ChurchRosser r

ExternalTheorem confluent_iff_churchRosser
  := @Relation.Confluent_iff_ChurchRosser
  : ∀ {α : Type u_1} {r : α → α → Prop},
    Relation.Confluent r ↔ Relation.ChurchRosser r

ExternalTheorem confluent_iff_semiconfluent
  := @Relation.Confluent_iff_SemiConfluent
  : ∀ {α : Type u_1} {r : α → α → Prop},
    Relation.Confluent r ↔ Relation.SemiConfluent r

ExternalTheorem confluent_of_unique_end
  := @Relation.Confluent_of_unique_end
  : ∀ {α : Type u_1} {r : α → α → Prop} {x : α},
    (∀ (y : α), Relation.ReflTransGen r y x) → Relation.Confluent r

-- ════════════════════════════════════════════
-- Normal forms
-- ════════════════════════════════════════════

ExternalTheorem normal_iff
  := @Relation.Normal_iff
  : ∀ {α : Type u_1} (r : α → α → Prop) (x : α),
    Relation.Normal r x ↔ ∀ (y : α), ¬r x y

ExternalTheorem normal_reflTransGen_eq
  := @Relation.Normal.reflTransGen_eq
  : ∀ {α : Type u_1} {r : α → α → Prop} {x y : α},
    Relation.Normal r x → Relation.ReflTransGen r x y → x = y

ExternalTheorem churchRosser_normal_eqvGen_reflTransGen
  := @Relation.ChurchRosser.normal_eqvGen_reflTransGen
  : ∀ {α : Type u_1} {r : α → α → Prop} {x y : α},
    Relation.ChurchRosser r →
    Relation.Normal r x →
    Relation.EqvGen r y x →
    Relation.ReflTransGen r y x

ExternalTheorem churchRosser_normal_eq
  := @Relation.ChurchRosser.normal_eq
  : ∀ {α : Type u_1} {r : α → α → Prop} {x y : α},
    Relation.ChurchRosser r →
    Relation.Normal r x →
    Relation.Normal r y →
    Relation.EqvGen r x y →
    x = y

-- ════════════════════════════════════════════
-- Confluence produces an equivalence
-- ════════════════════════════════════════════

ExternalTheorem confluent_equivalence_join_reflTransGen
  := @Relation.Confluent.equivalence_join_reflTransGen
  : ∀ {α : Type u_1} {r : α → α → Prop},
    Relation.Confluent r →
    Equivalence (Relation.Join (Relation.ReflTransGen r))

-- ════════════════════════════════════════════
-- Termination
-- ════════════════════════════════════════════

ExternalTheorem terminating_toTransGen
  := @Relation.Terminating.toTransGen
  : ∀ {α : Type u_1} {r : α → α → Prop},
    Relation.Terminating r → Relation.Terminating (Relation.TransGen r)

ExternalTheorem terminating_ofTransGen
  := @Relation.Terminating.ofTransGen
  : ∀ {α : Type u_1} {r : α → α → Prop},
    Relation.Terminating (Relation.TransGen r) → Relation.Terminating r

ExternalTheorem terminating_iff_transGen
  := @Relation.Terminating.iff_transGen
  : ∀ {α : Type u_1} {r : α → α → Prop},
    Relation.Terminating (Relation.TransGen r) ↔ Relation.Terminating r

ExternalTheorem terminating_subrelation
  := @Relation.Terminating.subrelation
  : ∀ {α : Type u_1} {r r' : α → α → Prop},
    Relation.Terminating r → Subrelation r' r → Relation.Terminating r'

ExternalTheorem terminating_isNormalizing
  := @Relation.Terminating.isNormalizing
  : ∀ {α : Type u_1} {r : α → α → Prop},
    Relation.Terminating r → Relation.Normalizing r

ExternalTheorem terminating_isConfluent_iff_all_unique_Normal
  := @Relation.Terminating.isConfluent_iff_all_unique_Normal
  : ∀ {α : Type u_1} {r : α → α → Prop},
    Relation.Terminating r →
    (Relation.Confluent r ↔
      ∀ (a : α), ∃! n, Relation.ReflTransGen r a n ∧ Relation.Normal r n)

-- ════════════════════════════════════════════
-- Convergent relations (confluent + terminating)
-- ════════════════════════════════════════════

ExternalTheorem convergent_isTerminating
  := @Relation.Convergent.isTerminating
  : ∀ {α : Type u_1} {r : α → α → Prop},
    Relation.Convergent r → Relation.Terminating r

ExternalTheorem convergent_isConfluent
  := @Relation.Convergent.isConfluent
  : ∀ {α : Type u_1} {r : α → α → Prop},
    Relation.Convergent r → Relation.Confluent r

ExternalTheorem convergent_isNormalizing
  := @Relation.Convergent.isNormalizing
  : ∀ {α : Type u_1} {r : α → α → Prop},
    Relation.Convergent r → Relation.Normalizing r

ExternalTheorem convergent_unique_Normal
  := @Relation.Convergent.unique_Normal
  : ∀ {α : Type u_1} {r : α → α → Prop},
    Relation.Convergent r →
    ∀ (a : α), ∃! n, Relation.ReflTransGen r a n ∧ Relation.Normal r n

-- ════════════════════════════════════════════
-- Local confluence and Newman's lemma
-- ════════════════════════════════════════════

ExternalTheorem confluent_toLocallyConfluent
  := @Relation.Confluent.toLocallyConfluent
  : ∀ {α : Type u_1} {r : α → α → Prop},
    Relation.Confluent r → Relation.LocallyConfluent r

ExternalTheorem locallyConfluent_terminating_toConfluent
  := @Relation.LocallyConfluent.Terminating_toConfluent
  : ∀ {α : Type u_1} {r : α → α → Prop},
    Relation.LocallyConfluent r → Relation.Terminating r → Relation.Confluent r

-- ════════════════════════════════════════════
-- Strong confluence
-- ════════════════════════════════════════════

ExternalTheorem stronglyConfluent_toConfluent
  := @Relation.StronglyConfluent.toConfluent
  : ∀ {α : Type u_1} {r : α → α → Prop},
    Relation.StronglyConfluent r → Relation.Confluent r

-- ════════════════════════════════════════════
-- Commuting relations
-- ════════════════════════════════════════════

ExternalTheorem commute_symmetric
  := @Relation.Commute.symmetric
  : ∀ {α : Type u_1}, Symmetric (@Relation.Commute α)

ExternalTheorem commute_toConfluent
  := @Relation.Commute.toConfluent
  : ∀ {α : Type u_1} {r : α → α → Prop},
    Relation.Commute r r = Relation.Confluent r

ExternalTheorem stronglyCommute_toStronglyConfluent
  := @Relation.StronglyCommute.toStronglyConfluent
  : ∀ {α : Type u_1} {r : α → α → Prop},
    Relation.StronglyCommute r r = Relation.StronglyConfluent r

ExternalTheorem diamondCommute_toDiamond
  := @Relation.DiamondCommute.toDiamond
  : ∀ {α : Type u_1} {r : α → α → Prop},
    Relation.DiamondCommute r r = Relation.Diamond r

ExternalTheorem stronglyCommute_extend
  := @Relation.StronglyCommute.extend
  : ∀ {α : Type u_1} {r₁ r₂ : α → α → Prop} {x y z : α},
    Relation.StronglyCommute r₁ r₂ →
    Relation.ReflTransGen r₁ x y →
    r₂ x z →
    ∃ w, Relation.ReflGen r₂ y w ∧ Relation.ReflTransGen r₁ z w

ExternalTheorem stronglyCommute_toCommute
  := @Relation.StronglyCommute.toCommute
  : ∀ {α : Type u_1} {r₁ r₂ : α → α → Prop},
    Relation.StronglyCommute r₁ r₂ → Relation.Commute r₁ r₂

-- ════════════════════════════════════════════
-- Sup (join) of relations
-- ════════════════════════════════════════════

ExternalTheorem join_inl
  := @Relation.join_inl
  : ∀ {α : Type u_1} {r₁ r₂ : α → α → Prop} {a b : α},
    r₁ a b → (r₁ ⊔ r₂) a b

ExternalTheorem join_inr
  := @Relation.join_inr
  : ∀ {α : Type u_1} {r₁ r₂ : α → α → Prop} {a b : α},
    r₂ a b → (r₁ ⊔ r₂) a b

ExternalTheorem join_inl_reflTransGen
  := @Relation.join_inl_reflTransGen
  : ∀ {α : Type u_1} {r₁ r₂ : α → α → Prop} {a b : α},
    Relation.ReflTransGen r₁ a b → Relation.ReflTransGen (r₁ ⊔ r₂) a b

ExternalTheorem join_inr_reflTransGen
  := @Relation.join_inr_reflTransGen
  : ∀ {α : Type u_1} {r₁ r₂ : α → α → Prop} {a b : α},
    Relation.ReflTransGen r₂ a b → Relation.ReflTransGen (r₁ ⊔ r₂) a b

ExternalTheorem commute_join_left
  := @Relation.Commute.join_left
  : ∀ {α : Type u_1} {r₁ r₂ r₃ : α → α → Prop},
    Relation.Commute r₁ r₃ →
    Relation.Commute r₂ r₃ →
    Relation.Commute (r₁ ⊔ r₂) r₃

ExternalTheorem commute_join_confluent
  := @Relation.Commute.join_confluent
  : ∀ {α : Type u_1} {r₁ r₂ : α → α → Prop},
    Relation.Confluent r₁ →
    Relation.Confluent r₂ →
    Relation.Commute r₁ r₂ →
    Relation.Confluent (r₁ ⊔ r₂)

-- ════════════════════════════════════════════
-- Miscellaneous
-- ════════════════════════════════════════════

ExternalTheorem reflTransGen_mono_closed
  := @Relation.reflTransGen_mono_closed
  : ∀ {α : Type u_1} {r₁ r₂ : α → α → Prop},
    Subrelation r₁ r₂ →
    Subrelation r₂ (Relation.ReflTransGen r₁) →
    Relation.ReflTransGen r₁ = Relation.ReflTransGen r₂

ExternalTheorem reflGen_compRel_symm
  := @Relation.ReflGen.compRel_symm
  : ∀ {α : Type u_1} {r : α → α → Prop} {a b : α},
    Relation.ReflGen (Relation.SymmGen r) a b →
    Relation.ReflGen (Relation.SymmGen r) b a

ExternalTheorem reflTransGen_compRel
  := @Relation.reflTransGen_compRel
  : ∀ {α : Type u_1} {r : α → α → Prop},
    Relation.ReflTransGen (Relation.SymmGen r) = Relation.EqvGen r

ExternalTheorem rightUnique_toConfluent
  := @Relation.RightUnique.toConfluent
  : ∀ {α : Type u_1} {r : α → α → Prop},
    Relator.RightUnique r → Relation.Confluent r
