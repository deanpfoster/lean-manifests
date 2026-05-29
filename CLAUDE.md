# CLAUDE.md — for agents working on lean-manifests itself

> **Starting a project that depends on lean-manifests?** This file is
> the workflow for working ON lean-manifests itself. For downstream
> projects, copy `templates/CLAUDE.md` (or `templates/AGENTS.md`) to
> your project root. See `templates/README.md` for details.
>
> **The two seed files for downstream projects** are
> `templates/MANIFEST_GUIDE.md` (the working manual; § 5e and § 5f
> are the most important sections) and
> `templates/examples-of-good-theorems.lean` (canonical patterns
> drawn from production Lean software — lean-zip, RadixExperiment).
> Anyone authoring manifest entries should read both before
> starting.

## What this repo is

A Lean 4 library of macros and tooling for evidence-tagged claims.
The library is consumed as a path-dep or git-dep by downstream
projects (l3m, lean-stats, markdown-cm, dean_cpp). It does NOT have
significant runtime; almost everything happens at elaboration time.

The user-facing surface is in `LeanManifests/`:

- `Basic.lean` — the seven evidence-level macros (`ProvenTheorem`,
  `DerivedConjecture`, `DecomposedConjecture`, `TestedConjecture`,
  `UnprovenConjecture`, `Sketch`, `ConformanceFixture`).
  Read this first.
- `WorldClaim.lean` — the eighth: `WorldClaim`, for permanent
  environmental facts. Doc-comment is mandatory (`throwError`).
- `Attr.lean`, `RegisteredAttr.lean` — attribute infrastructure that
  the macros build on. Not normally imported by downstream code.
- `Conformance/` — reference-system framework (R, numpy, SQL, spec).
- `IndexGen.lean`, `Workplan.lean`, `LibraryTame.lean`,
  `LatexExtract.lean`, `LatexRoundtrip.lean` — tooling.
- `Manifests/`, `Defs/Manifests/`, `Proofs/Manifests/` — the
  meta-manifest about the macros' own contracts (the macros documenting
  themselves using themselves).
- `Tests/` — the test corpus, exercising every macro shape.

## Build & verify

```bash
~/.elan/bin/lake build           # full build
~/.elan/bin/lake build LeanManifests.Tests.WorldClaimTests  # specific test
```

`autoImplicit` is set to `false` package-wide. All type variables need
explicit `variable` declarations.

## Evidence hierarchy at a glance

```
○ UnprovenConjecture    sorry is the whole theorem
◐ TestedConjecture      sorry is the ∀; concrete witness (foo_test) exists
◑ DecomposedConjecture  sorry is in lemmas; all are at least TestedConjecture
◕ DerivedConjecture     sorry is in OTHER modules; this proof is real
● ProvenTheorem         no sorry in transitive closure
🌍 WorldClaim           env-axiomatic; doc-comment is the artifact
✎ Sketch                name + prose, no Prop yet
=  ConformanceFixture   matches a named external system, non-promotable
```

Promotion: change one keyword, the build verifies the new requirements.

## When working on this repo

### Adding a new macro

1. Decide where the load-bearing artifact lives. If it's the type or
   proof, the macro can warn on missing doc-comments. If it's the
   doc-comment itself (Sketch, WorldClaim), the macro MUST hard-error.
   See `docs` discussion on doc-comment-as-artifact.
2. Implement in `LeanManifests/Basic.lean` (or its own file if it's
   substantial; e.g., `WorldClaim.lean`, `Conformance.lean`).
3. Add a test in `LeanManifests/Tests/`.
4. Update `LeanManifests.lean` (the root module) to re-export.
5. Update `templates/MANIFEST_GUIDE.md` with the new macro's intent
   and one good example.
6. Run the meta-manifest's tests — `Manifests/MacroContracts.lean` is
   our claim about how the macros behave, and it should still hold.

### Modifying an existing macro

1. Read `Manifests/MacroContracts.lean` for the contract.
2. Read the relevant `Tests/` file for examples that exercise the
   macro shape.
3. Make the change, re-run the build.
4. If the contract changes, update `Manifests/MacroContracts.lean` and
   `templates/MANIFEST_GUIDE.md` together.

### Tightening a soft check to a hard error

This pattern came up several times: a macro had a soft `logWarning`
that could be ignored. Switching to `throwError` makes the
discipline self-enforcing. Pattern:

1. Spot-check the existing usage in `lean-manifests` Tests AND in the
   downstream consumers (l3m, lean-stats, markdown-cm).
2. If all existing usages already satisfy the strict version,
   convert to `throwError`.
3. If not, fix the usages first (commits in those repos), then convert.
4. Update `templates/MANIFEST_GUIDE.md` to document the new strictness.

## Downstream dependents

- **l3m** — verified coding agent. Worktrees at `~/l3m.kiro.codeFirst`,
  `~/l3m.leanStatsConnection`, `~/l3m.production`. ~80 import sites.
- **lean-stats** — pure statistics library validated against R.
  Worktrees at `~/lean-stats.code_first`, `~/lean-stats.leanStatsConnection`.
- **markdown-cm** — CommonMark renderer with conformance proofs.
  Lives inside l3m worktrees as a path-dep at `markdown-cm/`.
- **dean_cpp** (separate repo) — C++ standard library formalization.

When making a breaking change here, plan the rollout across all four.
The safe ordering is:

  1. Land the change on `main` here (path-deps see it immediately for
     dev worktrees).
  2. Update each dependent's import sites + `lakefile.lean`.
  3. Build each dependent clean.
  4. Push lean-manifests after dependents are confirmed working.

For non-breaking additions (new macro, new tool), no coordination
needed — dependents pick it up on their next build.

## Writing good manifests

Read **`templates/MANIFEST_GUIDE.md`** before writing or reviewing any
manifest. Key principles:

- 4–6 headline claims written for the consumer, not proof obligations
- Explicit "What we do NOT claim" section
- `registerTestResults` on every conjecture with test coverage
- No vacuous totality (`∀ x, ∃ y, f x = y` is a tautology)
- No trivially decidable claims left as `UnprovenConjecture`
- Strip workplan metadata on promotion to ProvenTheorem

## Don't

- Don't add `axiom` declarations outside macros that explicitly emit
  axioms (`FastHeader`, `ManifestAxiom`). The whole point is that
  every axiom is named.
- Don't loosen a hard error to a warning without strong reason. The
  doc-comment-as-artifact discipline is one of the central
  contributions; warnings get ignored.
- Don't break the `Manifests/` meta-manifest. The macros documenting
  themselves is a load-bearing demonstration.
- Don't add `import` cycles. Tooling files (`Workplan`, `LatexExtract`)
  may import macros; macros may not import tooling.
