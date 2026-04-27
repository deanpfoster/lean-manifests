import DeanLean.Basic

/-! # Manifest for the Manifest System

  Self-referential: this file specifies what our macro system promises.
  Each claim is testable. When all are ProvenTheorem, the system is certified.

  ## Vocabulary

  The macros in Basic.lean process Lean commands at elaboration time.
  Each macro takes a name `n` and a type `t`, checks some condition,
  and emits a Lean declaration (theorem, axiom, def, or example).

  "Compiles" means: the emitted declaration is accepted by Lean's kernel.
  "Fails" means: the macro throws an error that stops compilation.
  "Warns" means: the macro emits a warning but compilation continues.

  ## Evidence Hierarchy (strictly ordered)

  ○ UnprovenConjecture    — sorry IS the theorem
  ◐ TestedConjecture      — sorry is the ∀ (witness required)
  ◑ DecomposedConjecture  — sorry is in the lemmas (all tested)
  ◕ DerivedConjecture     — sorry is in other modules
  ● ProvenTheorem         — no sorry anywhere
-/

-- ════════════════════════════════════════════════════════════
-- § ProvenTheorem behavior
-- ════════════════════════════════════════════════════════════

-- Core contract: ProvenTheorem creates a theorem from foo_proof
UnprovenConjecture ProvenTheorem_creates_theorem :
    True -- "ProvenTheorem foo : T creates theorem foo : T := foo_proof"

-- Fails without proof
UnprovenConjecture ProvenTheorem_fails_without_proof :
    True -- "ProvenTheorem foo : T fails if neither foo_proof nor foo_derivation exists"

-- Accepts _derivation as alternative to _proof
UnprovenConjecture ProvenTheorem_accepts_derivation :
    True -- "ProvenTheorem foo : T succeeds if foo_derivation exists (no rename needed)"

-- Type mismatch fails
UnprovenConjecture ProvenTheorem_type_mismatch_fails :
    True -- "ProvenTheorem foo : T fails if foo_proof has type U ≠ T"

-- Redundant: silently type-checks if name already exists (same namespace)
UnprovenConjecture ProvenTheorem_redundant_same_namespace :
    True -- "ProvenTheorem foo : T succeeds (type-check only) if foo already defined"

-- Fast mode: emits axiom instead of looking up proof
UnprovenConjecture ProvenTheorem_fast_mode_axiom :
    True -- "With levelized.fast=true, ProvenTheorem foo : T emits axiom foo : T"

-- ════════════════════════════════════════════════════════════
-- § TestedConjecture behavior
-- ════════════════════════════════════════════════════════════

-- Core contract: requires foo_test
UnprovenConjecture TestedConjecture_requires_test :
    True -- "TestedConjecture foo : T fails if foo_test doesn't exist"

-- Creates sorry theorem
UnprovenConjecture TestedConjecture_creates_sorry :
    True -- "TestedConjecture foo : T creates theorem foo : T := by sorry"

-- Warns on vacuous test
UnprovenConjecture TestedConjecture_warns_vacuous :
    True -- "Warns if foo_test uses absurd/False.elim/Not.elim/False.rec"

-- Vacuous warning suppressible
UnprovenConjecture TestedConjecture_classical_suppression :
    True -- "No warning if foo_test_is_classical exists"

-- ════════════════════════════════════════════════════════════
-- § DecomposedConjecture behavior
-- ════════════════════════════════════════════════════════════

-- Core contract: requires foo_derivation AND all sorry deps tested
UnprovenConjecture DecomposedConjecture_requires_derivation :
    True -- "Fails if foo_derivation doesn't exist"

UnprovenConjecture DecomposedConjecture_requires_all_tested :
    True -- "Fails if any sorry dep of foo_derivation lacks _test"

-- Strictly stronger than TestedConjecture
UnprovenConjecture DecomposedConjecture_stronger_than_tested :
    True -- "Every valid DecomposedConjecture could also be a TestedConjecture"

-- ════════════════════════════════════════════════════════════
-- § DerivedConjecture behavior
-- ════════════════════════════════════════════════════════════

-- Core contract: requires foo_derivation, auto-reports sorry deps
UnprovenConjecture DerivedConjecture_requires_derivation :
    True -- "Fails if foo_derivation doesn't exist"

UnprovenConjecture DerivedConjecture_auto_discovers_sorry :
    True -- "Reports sorry deps via getUsedConstantsAsSet"

UnprovenConjecture DerivedConjecture_reports_fraction :
    True -- "Reports N/M theorem deps proven (P%)"

UnprovenConjecture DerivedConjecture_suggests_promotion :
    True -- "When 0 sorry deps, says 'consider promoting to ProvenTheorem'"

-- ════════════════════════════════════════════════════════════
-- § Signature behavior
-- ════════════════════════════════════════════════════════════

-- Checks function exists with stated type
UnprovenConjecture Signature_checks_type :
    True -- "Signature foo : T fails if foo exists with type U ≠ T"

-- Creates axiom if function doesn't exist
UnprovenConjecture Signature_creates_axiom :
    True -- "Signature foo : T creates axiom foo : T if foo not found"

-- Rejects partial functions
UnprovenConjecture Signature_rejects_partial :
    True -- "Signature foo : T fails if foo is partial (use PartialSignature)"

-- ════════════════════════════════════════════════════════════
-- § Redundancy behavior (all evidence macros)
-- ════════════════════════════════════════════════════════════

-- Same namespace: silently verifies
UnprovenConjecture redundancy_same_namespace :
    True -- "Any evidence macro with an existing name (same ns) type-checks silently"

-- Type mismatch in redundant manifest: fails
UnprovenConjecture redundancy_type_mismatch_fails :
    True -- "Redundant declaration with wrong type fails to compile"

-- TODO: open namespace redundancy (not yet working)
UnprovenConjecture redundancy_open_namespace :
    True -- "Redundant declaration via 'open Foo' should also work"

-- ════════════════════════════════════════════════════════════
-- § VerifyAxiom behavior
-- ════════════════════════════════════════════════════════════

UnprovenConjecture VerifyAxiom_confirms_match :
    True -- "VerifyAxiom foo : T succeeds with info message if foo_proof : T exists"

UnprovenConjecture VerifyAxiom_fails_without_proof :
    True -- "VerifyAxiom foo : T fails if neither foo_proof nor foo_derivation found"

-- ════════════════════════════════════════════════════════════
-- § Evidence ordering invariant
-- ════════════════════════════════════════════════════════════

-- The hierarchy is strictly ordered: each level requires everything below
UnprovenConjecture hierarchy_strict_ordering :
    True -- "DecomposedConjecture ⊃ TestedConjecture ⊃ UnprovenConjecture"

-- Promotion never breaks: changing keyword upward always compiles if evidence exists
UnprovenConjecture promotion_monotonic :
    True -- "If DerivedConjecture foo compiles, ProvenTheorem foo compiles when sorry=0"
