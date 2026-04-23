# CSLib Header -- Languages.CCS

## Module Summary

**CCS (Calculus of Communicating Systems)** is a process algebra introduced by Robin Milner
[Milner80] for modeling concurrent systems. Processes communicate by synchronizing on
complementary channel names (handshake communication). This CSLib module provides a complete
formalization of CCS following the presentation in Sangiorgi's *Introduction to Bisimulation
and Coinduction* [Sangiorgi2011].

The formalization covers three layers:

1. **Syntax** (`Basic.lean`) -- Processes, actions, co-actions, and syntactic contexts with a
   completeness proof showing contexts capture all CCS syntax.
2. **Operational Semantics** (`Semantics.lean`) -- A labelled transition system (LTS) defined
   by structural operational semantics rules, including constant unfolding.
3. **Behavioural Theory** (`BehaviouralTheory.lean`) -- Bisimilarity laws for parallel
   composition, choice, prefixing, and restriction, culminating in the proof that bisimilarity
   is a congruence.

---

## Vocabulary

All definitions live in namespace `Cslib.CCS` unless otherwise noted.

### Inductive Types

| Name | File | Description |
|------|------|-------------|
| `Act (Name : Type u)` | Basic | Actions: `name a`, `coname a`, or `τ` (internal). |
| `Process (Name : Type u) (Constant : Type v)` | Basic | Processes: `nil`, `pre μ p` (prefix), `par p q` (parallel), `choice p q` (nondeterministic choice), `res a p` (restriction), `const c` (constant invocation). |
| `Act.IsVisible` | Basic | Predicate: an action is visible iff it is `name a` or `coname a`. |
| `Act.Co` | Basic | Complementarity relation on actions: `name a` is co to `coname a` and vice versa. |
| `Context (Name : Type u) (Constant : Type v)` | Basic | One-hole syntactic contexts: `hole`, `pre`, `parL`, `parR`, `choiceL`, `choiceR`, `res`. |
| `Tr` | Semantics | Transition relation `Process -> Act -> Process -> Prop`. Rules: `pre`, `parL`, `parR`, `com` (synchronization), `choiceL`, `choiceR`, `res` (with side conditions), `const` (constant unfolding). |
| `Terminated` | Semantics | A process is terminated if it is a composition of `nil`s (through `par`, `choice`, `res`). |

### Definitions

| Name | File | Type | Description |
|------|------|------|-------------|
| `Act.isCo` | Basic | `[DecidableEq Name] -> Act Name -> Act Name -> Bool` | Boolean decision procedure for co-action relation. |
| `Context.fill` | Basic | `Context Name Constant -> Process Name Constant -> Process Name Constant` | Fills the hole in a context with a process. |

### Instances

| Name | File | Description |
|------|------|-------------|
| `HasContext (Process Name Constant)` | Basic | Context structure for CCS processes. |
| `Decidable (Act.Co mu mu')` | Basic | Co-action relation is decidable when `Name` has `DecidableEq`. |
| `HasTau (Act Name)` | Semantics | Identifies `Act.tau` as the silent action for LTS infrastructure. |
| `bisimilarityCongruence` | BehaviouralTheory | `Congruence (Process Name Constant) (HomBisimilarity (lts ...))` -- bisimilarity is a congruence. |

---

## Theorem Listing

All theorems carry implicit variables:
```
{Name : Type u} {Constant : Type v} {defs : Constant -> CCS.Process Name Constant -> Prop}
```
and operate over `lts (defs := defs)` unless stated otherwise.

### STRUCTURAL -- Process Algebra Laws

These are standard algebraic laws of CCS up to bisimilarity.

```lean
-- Parallel composition: nil is a unit
theorem bisimilarity_par_nil :
    (par p nil) ~[lts (defs := defs)] p

theorem bisimilarity_nil_par :
    (par nil p) ~[lts (defs := defs)] p

-- Parallel composition: commutativity
theorem bisimilarity_par_comm :
    (par p q) ~[lts (defs := defs)] (par q p)

-- Parallel composition: associativity
theorem bisimilarity_par_assoc :
    (par p (par q r)) ~[lts (defs := defs)] (par (par p q) r)

-- Choice: nil is a unit
theorem bisimilarity_choice_nil :
    (choice p nil) ~[lts (defs := defs)] p

-- Choice: idempotence
theorem bisimilarity_choice_idem :
    (choice p p) ~[lts (defs := defs)] p

-- Choice: commutativity
theorem bisimilarity_choice_comm :
    (choice p q) ~[lts (defs := defs)] (choice q p)

-- Choice: associativity
theorem bisimilarity_choice_assoc :
    (choice p (choice q r)) ~[lts (defs := defs)] (choice (choice p q) r)
```

### BEHAVIOURAL -- Bisimulation and Equivalence

```lean
-- Actions: visible actions are not tau
theorem Act.isVisible_neq_τ {μ : Act Name} (h : μ.IsVisible) : μ ≠ Act.τ

-- Co-actions: symmetry
theorem Act.Co.symm (h : Act.Co μ μ') : Act.Co μ' μ

-- Co-actions: both sides are visible
theorem co_isVisible (h : Act.Co μ μ') : μ.IsVisible ∧ μ'.IsVisible

-- Co-actions: Boolean decision agrees with inductive
theorem isCo_iff [DecidableEq Name] {μ μ' : Act Name} :
    Act.isCo μ μ' ↔ Act.Co μ μ'

-- Context filling definition
theorem context_fill_def (c : Context Name Constant) (p : Process Name Constant) :
    c<[p] = c.fill p

-- Context completeness: every process decomposes into a context filled with an atom
theorem Context.complete (p : Process Name Constant) :
    ∃ c : Context Name Constant,
      p = c<[(Process.nil : Process Name Constant)] ∨
      ∃ k : Constant, p = c<[(Process.const k : Process Name Constant)]
```

### CONGRUENCE -- Operators Preserve Equivalence

```lean
-- Prefixing preserves bisimilarity
theorem bisimilarity_congr_pre :
    (p ~[lts (defs := defs)] q) →
    (pre μ p) ~[lts (defs := defs)] (pre μ q)

-- Restriction preserves bisimilarity
theorem bisimilarity_congr_res :
    (p ~[lts (defs := defs)] q) →
    (res a p) ~[lts (defs := defs)] (res a q)

-- Choice preserves bisimilarity (left argument)
theorem bisimilarity_congr_choice :
    (p ~[lts (defs := defs)] q) →
    (choice p r) ~[lts (defs := defs)] (choice q r)

-- Parallel composition preserves bisimilarity (left argument)
theorem bisimilarity_congr_par :
    (p ~[lts (defs := defs)] q) →
    (par p r) ~[lts (defs := defs)] (par q r)

-- Master congruence: bisimilarity is preserved by arbitrary context filling
theorem bisimilarity_is_congruence
    (p q : Process Name Constant) (c : Context Name Constant)
    (h : p ~[lts (defs := defs)] q) :
    (c.fill p) ~[lts (defs := defs)] (c.fill q)

-- Bundled instance: bisimilarity is a congruence in CCS
instance bisimilarityCongruence :
    Congruence (Process Name Constant) (HomBisimilarity (lts (defs := defs)))
```

---

## Dependencies

### Internal (CSLib)

| Import | Used by | Purpose |
|--------|---------|---------|
| `Cslib.Foundations.Syntax.Context` | Basic | `HasContext` typeclass and context-filling notation `c<[p]` |
| `Cslib.Foundations.Semantics.LTS.HasTau` | Semantics | `HasTau` typeclass identifying the silent action |
| `Cslib.Foundations.Semantics.LTS.Notation` | Semantics | LTS transition notation (meta import) |
| `Cslib.Foundations.Semantics.LTS.Bisimulation` | BehaviouralTheory | `Bisimilarity`, `HomBisimilarity`, bisimulation infrastructure |
| `Cslib.Foundations.Syntax.Congruence` | BehaviouralTheory | `Congruence`, `Covariant` typeclasses |
| `Cslib.Languages.CCS.Basic` | Semantics | Syntax definitions |
| `Cslib.Languages.CCS.Semantics` | BehaviouralTheory | Transition relation and LTS |

### External (Mathlib)

| Import | Used by | Purpose |
|--------|---------|---------|
| `Mathlib.Tactic.ToAdditive` | Basic | Tactic support |
| `Mathlib.Tactic.ToDual` | Basic | Tactic support |

---

## Statistics

| Metric | Value |
|--------|-------|
| Files | 3 |
| Total lines | 671 |
| Lines in Basic.lean | 158 |
| Lines in Semantics.lean | 60 |
| Lines in BehaviouralTheory.lean | 453 |
| Inductive types (public) | 7 (`Act`, `Process`, `Act.IsVisible`, `Act.Co`, `Context`, `Tr`, `Terminated`) |
| Definitions | 2 (`isCo`, `Context.fill`) |
| Instances | 4 (`HasContext`, `Decidable Co`, `HasTau`, `bisimilarityCongruence`) |
| Theorems (total) | 19 |
| -- Structural (algebra laws) | 8 |
| -- Behavioural (actions, contexts) | 6 |
| -- Congruence | 5 (4 per-operator + 1 master + 1 instance) |
| Private helper relations | 8 (`ParNil`, `ParComm`, `ParAssoc`, `ChoiceNil`, `ChoiceIdem`, `ChoiceComm`, `ChoiceAssoc`, `PreBisim`, `ResBisim`, `ParBisim`, `ChoiceBisim`) |
| `@[simp]` lemmas | 2 (`bisimilarity_par_nil`, `bisimilarity_nil_par`) |
| `DecidableEq` derivations | 3 (`Act`, `Process`, `Context`) |

---

*Generated from CSLib sources. Author: Fabrizio Montesi. References: [Milner80], [Sangiorgi2011].*
