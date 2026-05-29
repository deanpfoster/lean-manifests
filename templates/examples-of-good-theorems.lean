/-
Examples of good theorems — read this BEFORE writing manifest entries.

This file is a SEED for agents. Read every example. The patterns
shown here are what your code should look like. Theorems imitate
examples; if your seed examples are dress-up, your output will be
dress-up. If your seed examples are structural, your output will
be structural.

The patterns below are drawn from two real production Lean
verification projects:

  * lean-zip (Kim Morrison) — zlib bindings, 359 theorems, 33K LoC,
    zero `native_decide`, zero `partial def` in pure modules.
  * RadixExperiment (Leo de Moura) — verified DSL, 52 theorems,
    7.4K LoC, zero `native_decide`, AI-built in one weekend.

The single most important discipline: **structural proofs, not
fixture proofs**. `native_decide` is a power tool. It is not a
default proof method. If `native_decide` is what your proof
*could* be, ask whether the theorem you're stating is actually a
unit test wearing theorem clothing.

Pre-reading: `MANIFEST_GUIDE.md` § 5e (UnitTest vs ProvenTheorem)
and § 5f (the pivot toward Leo-style proofs).
-/

import LeanManifests.Basic

namespace Examples

/-! # 1. The canonical shape: relational spec ↔ implementation

The single most powerful pattern in Lean verification is to define
the SPEC as a relation (or inductive predicate) and the IMPLEMENTATION
as an executable function, then prove they agree.

This is the Xavier Leroy / Adam Chlipala pattern. Every interpreter,
parser, compiler pass, and stateful protocol can use this shape.
-/

/-- Toy language: a tiny expression evaluator. -/
inductive Expr
  | lit : Nat → Expr
  | add : Expr → Expr → Expr
  deriving Repr

/-- The SPEC: a relational big-step semantics. This says what
    evaluation MEANS, not how it's implemented. -/
inductive Eval : Expr → Nat → Prop
  | lit (n : Nat) : Eval (.lit n) n
  | add {e₁ e₂ n₁ n₂} : Eval e₁ n₁ → Eval e₂ n₂ → Eval (.add e₁ e₂) (n₁ + n₂)

/-- The IMPLEMENTATION: an executable evaluator. -/
def eval : Expr → Nat
  | .lit n => n
  | .add e₁ e₂ => eval e₁ + eval e₂

/-- **Soundness**: the implementation never produces a value the
    spec doesn't allow. (For total deterministic evaluators this
    is trivially true; the theorem still pins the contract.)

    Real proof: structural induction. No `native_decide`. -/
theorem eval_sound : ∀ e, Eval e (eval e) := by
  intro e
  induction e with
  | lit n => exact .lit n
  | add e₁ e₂ ih₁ ih₂ => exact .add ih₁ ih₂

/-- **Completeness**: every value the spec allows is what the
    implementation actually computes. -/
theorem eval_complete : ∀ {e n}, Eval e n → eval e = n := by
  intro e n h
  induction h with
  | lit n => rfl
  | add _ _ ih₁ ih₂ => simp [eval, ih₁, ih₂]

/-! Both proofs are short structural inductions. They generalize
    over ALL inputs (the universal `∀`). They use `rfl` and `simp`
    and `exact` — no `native_decide` anywhere. The kernel checks
    every step.

    This is what a real theorem looks like.

    **Compare to the dress-up version:**

    ```lean
    -- DRESS-UP: do not write theorems like this.
    UnitTest eval_lit_5 : eval (.lit 5) = 5  -- proven by native_decide
    UnitTest eval_add_2_3 : eval (.add (.lit 2) (.lit 3)) = 5
    UnitTest eval_nested : eval (.add (.add (.lit 1) (.lit 2)) (.lit 3)) = 6
    ```

    Three UnitTests vs. one structural theorem. The structural
    theorem proves the universal claim once and forever; the
    UnitTests prove three specific cases. The structural theorem
    is the right artifact. The UnitTests are noise. -/


/-! # 2. When `UnitTest` is the right answer

A `UnitTest` is honest when it pins a SPECIFIC INCIDENT or a
SPECIFIC ATTACK PATTERN that you want to remain caught even if
the universal theorem regresses for some other reason.

Canonical example: a regression test for the exact byte sequence
that caused a real production incident.
-/

/-- A toy redactor that replaces "secret-" prefixed tokens. -/
def redactSecret (s : String) : String :=
  if s.startsWith "secret-" then "[REDACTED]" else s

/-- **Real theorem**: any string starting with `secret-` is fully
    redacted. This is universal. -/
theorem redactSecret_redacts_prefix :
    ∀ s, s.startsWith "secret-" = true → redactSecret s = "[REDACTED]" := by
  intro s h
  simp [redactSecret, h]

/-- **UnitTest**: a specific historical incident pattern.
    The universal theorem above already covers this case, but the
    UnitTest is here as an anti-regression-guard for the exact
    string that caused [reference: incident #42, 2026-04-12]. -/
UnitTest redactSecret_handles_incident_42 :
  redactSecret "secret-tfvL5abcdefghijk" = "[REDACTED]"

/-! The UnitTest is honest because it documents WHY this specific
    fixture exists. The doc-comment pattern for a UnitTest should
    always answer: "what historical regression does this prevent?"
    If the answer is "none, I just wanted to test this case," the
    UnitTest is dress-up; either prove the universal or delete the
    fixture. -/


/-! # 3. Determinism and observational equivalence

Another high-value pattern: prove that a stateful operation has
exactly one outcome from any state. This is the BigStep.det
pattern from Leo's RadixExperiment.
-/

/-- A toy state-machine step. -/
inductive Step : Nat → Nat → Prop
  | inc {n} : Step n (n + 1)

/-- Determinism: same input state → same output state. -/
theorem Step.det : ∀ {n m₁ m₂}, Step n m₁ → Step n m₂ → m₁ = m₂ := by
  intro n m₁ m₂ h₁ h₂
  cases h₁; cases h₂; rfl


/-! # 4. Optimization correctness

For each program transformation `f : T → T`, prove it preserves
the semantic content. One theorem per pass. This is RadixExperiment's
shape for `constFold`, `deadCodeElim`, etc.
-/

/-- A trivial "optimization": double a literal in place. -/
def doubleLit : Expr → Expr
  | .lit n => .lit (2 * n)
  | .add e₁ e₂ => .add (doubleLit e₁) (doubleLit e₂)

/-- The optimization, applied uniformly, multiplies all literal
    values by 2 — but is OBSERVATIONALLY DIFFERENT from the
    original (this is just a contrived demo). The theorem we'd
    really want is `eval (opt e) = eval e` for a real
    semantics-preserving optimization. -/
theorem doubleLit_doubles_value : ∀ e, eval (doubleLit e) = 2 * eval e := by
  intro e
  induction e with
  | lit n => rfl
  | add e₁ e₂ ih₁ ih₂ =>
    simp only [doubleLit, eval, ih₁, ih₂]
    omega


/-! # 5. Closed-inductive enumerations

Sometimes a theorem says "for any constructor of this inductive
type, property P holds." When the inductive has ≤ 10 constructors
and P is decidable, `decide` (NOT `native_decide`) works:
-/

inductive Color
  | red | green | blue
  deriving DecidableEq

def isWarm : Color → Bool
  | .red => true
  | _ => false

/-- For closed enumerations with `DecidableEq`, structural case
    analysis gives a real proof: -/
theorem warmth_only_red : ∀ c, isWarm c = true ↔ c = .red := by
  intro c
  cases c <;> simp [isWarm]


/-! # 6. When `native_decide` IS legitimate

The exception list. `native_decide` is acceptable when the proof
is exhaustive checking over a FIXED, FINITE structure that's
generated mechanically (not an arbitrary fixture).

Canonical case: capability-confinement proofs that walk a
generated call graph. The call graph is regenerated by a build
script; the theorem says "for every constant in this generated
list, property P holds"; `native_decide` runs the check.

```lean
-- ACCEPTABLE: closed enumeration over generated data
theorem fs_io_only_via_FsCap :
    ∀ c ∈ Generated.callGraph, c.respectsFsCap := by
  native_decide
```

The justification:
  * The call graph is mechanical, not handwritten fixture data.
  * The theorem is universally quantified over the whole graph.
  * The proof is "check every entry"; that's what `native_decide`
    does.

This is the ONLY pattern where `native_decide` belongs in a
ProvenTheorem. Anywhere else, it's a sign you're writing a
UnitTest in disguise.
-/


/-! # 7. The bookkeeping question

When should you reach for a manifest macro vs. a plain `theorem`?

  * **`ProvenTheorem`** — the theorem is part of the project's
    user-facing trust report. Promise to a user, contract for a
    consumer, security boundary. Must be backed by a structural
    proof (NOT `native_decide`, except for the case in §6).

  * **`UnitTest`** — fixture-shaped. Either pinning a specific
    incident OR documenting an API contract a user might verify.
    Doc-comment must say WHY this specific fixture exists.

  * **`UnprovenConjecture`** — known TODO; the prop is stated, the
    proof is sorry. Build accepts it but flags it as unproven.

  * **plain `theorem` (with `private` if appropriate)** — internal
    helper lemma. NOT promoted to the trust report. Use this for
    lemmas that support a ProvenTheorem above them. Most of
    lean-zip's "below the line" facts are private theorems, not
    UnitTests.

The rule of thumb: if you'd write `private theorem foo := by rfl`
for a fixture in lean-zip, write the same here. Don't elevate
helper lemmas to manifest entries; the trust report should reflect
LOAD-BEARING claims, not every concrete computation.
-/


/-! # 8. Anti-patterns: don't do this

```lean
-- ANTI-PATTERN: native_decide on a fixture, labeled as ProvenTheorem.
-- The right answer is either (a) write the universal theorem, or
-- (b) demote to UnitTest with a doc-comment explaining the incident.
ProvenTheorem foo_returns_42_on_input_X :
  foo "specific input X" = 42 := by native_decide

-- ANTI-PATTERN: partial def in a pure module.
-- This blocks all structural proofs about the function.
-- Refactor to total via termination_by or restructure with fuel.
partial def walk (s : String) (i : Nat) : Nat :=
  if i ≥ s.length then i else walk s (i + 1)

-- ANTI-PATTERN: theorem statement that's just a definitional
-- unfolding. If the proof is `rfl`, the theorem may not be
-- earning its keep — consider whether the function definition
-- itself is the right artifact.
theorem foo_def : foo x = bar x := rfl  -- prefer @[simp] on the def

-- ANTI-PATTERN: existential without content.
-- ∃ y, f x = y is true for any total function. Says nothing.
theorem foo_total : ∀ x, ∃ y, foo x = y := fun x => ⟨foo x, rfl⟩
```
-/

end Examples
