import DeanLean.Manifests.MacroContracts

/-! # Manifest for the Lean Manifests System

  This is the top-level manifest. It re-exports:
  - LeanEnvironment.lean: 16 claims about Lean's Environment API (to Leo)
  - MacroContracts.lean: 3 DerivedConjectures about our macros (from us)

  The general contracts are parameterized by Name, not specific constants:
  - ProvenTheoremSpec: ∀ env n t, n_proof exists → sorry-free thmInfo
  - TestedConjectureSpec: ∀ env n t, n_test exists → sorry thmInfo
  - EvidenceOrderingInvariant: sorry presence distinguishes levels

  Environment-level tests in Tests/EnvironmentTests.lean verify
  these contracts on concrete names at elaboration time.

  ## Evidence Hierarchy (the whole point)

  ○ UnprovenConjecture    — sorry IS the theorem
  ◐ TestedConjecture      — sorry is the ∀ (witness required)
  ◑ DecomposedConjecture  — sorry is in the lemmas (all tested)
  ◕ DerivedConjecture     — sorry is in other modules
  ● ProvenTheorem         — no sorry anywhere

  ## Dependency chain

  Leo's Lean (200K+ lines)
    ↑ 16 UnprovenConjectures (LeanEnvironment.lean)
  Our macros (263 lines)
    ↑ 3 DerivedConjectures (MacroContracts.lean)
  Library manifests (CSLib, C++, Interval, etc.)
    ↑ ProvenTheorem / TestedConjecture / etc.
  Consumers
-/
