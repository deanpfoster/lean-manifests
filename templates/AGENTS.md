# AGENTS.md

<!--
  Generic agent-config template for projects using lean-manifests.
  Copy to your project root and customize. Rename to gemini.md,
  .cursorrules, .aiderconfig, etc. as your tool requires.
-->

## Project context

This is a Lean 4 project using **lean-manifests** for evidence-tagged
claims. Read these conventions before making changes.

<!-- BEGIN: lean-manifests-specific -->

## Required reading

Before writing or reviewing manifests, read **TWO** files in the
lean-manifests repo:

  1. **`templates/MANIFEST_GUIDE.md`** — the shape of a good manifest,
     the `registerTestResults` pattern, anti-patterns to avoid, and
     promotion discipline. Pay particular attention to § 5e (UnitTest
     vs ProvenTheorem) and § 5f (the semi-pivot toward Leo-style
     proofs).

  2. **`templates/examples-of-good-theorems.lean`** — canonical
     patterns drawn from production Lean software (lean-zip,
     RadixExperiment). Shows the relational-spec-vs-implementation
     pattern, soundness + completeness theorems, optimization
     correctness, and the one legitimate use of `native_decide`
     (exhaustive checking over a generated structure).

The single most important discipline: **prefer structural proofs**
(`rfl`, `simp`, `induction`, `decide`, `grind`, `omega`) over
`native_decide`. A `ProvenTheorem` whose proof is `native_decide` on
a fixture is dress-up — relabel it as `UnitTest` (honest) or write
the universal version with a real proof.

## Evidence hierarchy

Every claim has an explicit evidence level:

- `ProvenTheorem` — kernel-checked proof
- `DerivedConjecture` — proven modulo named axioms
- `ManifestAxiom` — permanent environmental assumption (OS, network)
- `TestedConjecture` — verified for concrete inputs at build time
- `UnprovenConjecture` — TODO

Stronger evidence binds you more strictly. A `ProvenTheorem` cannot
be broken without proof; a `ManifestAxiom` is trusted documentation.

## Workflow: consult theorems before modifying

Before changing a function:

```bash
bash Scripts/show-theorems.sh PROJECT.functionName
```

Read each theorem listed. They are the function's contract. If your
change breaks one, the theorem changes with it — never silently.

After changing:

```bash
bash Scripts/verify-all.sh
```

The build verifies all theorems. Don't suppress failures with `sorry`.

## Annotating new theorems

```lean
@[theorems my_theorem]
def myFunction := ...
```

Tag load-bearing relationships explicitly. Sparse is better than
dense; auto-detection covers the rest.

## Parallel work

If working alongside other agents, use the workplan:

```bash
lake env lean --run Scripts/Workplan.lean
```

Pick an entry point (no unmet deps) matching your time budget,
claim via commit, work. Strip workplan metadata
(`@[depends_on]`, `@[estimated_minutes]`, `@[entry_point]`) when
the entry promotes to ProvenTheorem or TestedConjecture.

## Forbidden patterns

These are kernel-blocked or audit-checked:

- Replacing `ProvenTheorem` with `sorry`
- Raw `axiom` in your project namespace (if `no_<NS>_raw_axioms`
  is enabled)
- `unsafe def` in your namespace
- `initialize` blocks (if `no_<NS>_initialize_blocks` is enabled)
- Bypassing the evidence hierarchy

## Honest scope

Manifests are tripwires at build time, not design specs at write
time. The pre-modification consultation step is workflow discipline,
not a system-enforced rule. The kernel catches most violations
eventually; your job is to consult so you don't waste cycles.

<!-- END: lean-manifests-specific -->


<!-- BEGIN: project-specific (customize) -->

## Project overview

<!-- TODO: 1-2 sentences on what this project does. -->

## Build & verify

```bash
source ~/.elan/env
lake build
# Add project-specific verification steps here
```

## Architecture

<!-- TODO: brief overview of directory structure. -->

## Key files

<!-- TODO: 3-5 entry points. -->

<!-- END: project-specific -->
