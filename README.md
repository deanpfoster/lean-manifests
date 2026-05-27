# lean-manifests

Macros and tooling for **evidence-tagged claims** in Lean 4.

The thesis: every claim in a Lean module should carry a named
evidence level, the compiler should track where every `sorry`
lives, and the trust report should be a build artifact.

## What's here

The `LeanManifests` namespace ships seven evidence-level macros and
a small set of build-time tools that walk the manifest environment.

### Macros

| Macro                  | Glyph | Meaning                                               |
|------------------------|-------|-------------------------------------------------------|
| `ProvenTheorem`        | ●     | Kernel-checked proof, sorry-free in transitive closure |
| `DerivedConjecture`    | ◕     | Proven modulo named manifest entries                  |
| `DecomposedConjecture` | ◑     | Derivation whose sorry deps are all `TestedConjecture` |
| `TestedConjecture`     | ◐     | Universal claim with passing test witness             |
| `UnprovenConjecture`   | ○     | TODO — a hole expected to close                       |
| `WorldClaim`           | 🌍    | Permanent environmental fact (OS, network, hardware)   |
| `Sketch`               | ✎     | A name with prose, no `Prop` yet                      |
| `ConformanceFixture`   | =     | Matches a named external system (R, numpy, ...)       |

Plus `ManifestAxiom` (deprecated alias for `WorldClaim`) and
`@[theorems]` for linking functions to their manifest entries.

### Tools

| Tool          | Purpose                                                                                |
|---------------|----------------------------------------------------------------------------------------|
| `IndexGen`    | Function ↔ theorem index generator                                                     |
| `Workplan`    | Surfaces sorry-using `@[manifest_entry]` and `@[sketch]` decls for parallel agents     |
| `LibraryTame` | Structural audit: walks the reachable surface of a library's API for unwanted features |
| `LatexExtract`| Dumps the manifest environment to JSON for paper-ready LaTeX appendices                |
| `LatexRoundtrip`| Verifies that LaTeX `\manifestThm{...}` markers resolve to real Lean entries        |
| `Conformance` | Reference-system framework (R, numpy, SQL, spec-fixtures)                              |

## How to use

In your `lakefile.lean`:

```lean
require lean_manifests from git
  "https://github.com/deanpfoster/lean-manifests" @ "main"
```

In your code:

```lean
import LeanManifests.Basic

ProvenTheorem foo : ∀ x, P x := by ...
WorldClaim os_assumption := ∀ x, Q x
DerivedConjecture combined : ∀ x, P x ∧ Q x :=
  fun x => ⟨foo x, os_assumption x⟩
```

The compiler tracks the evidence chain. Every `Sketch` and
`WorldClaim` requires a doc-comment (the macro hard-errors on
missing prose, since the doc-comment is the entire artifact). The
trust report shows what your top-level claims rest on.

## Design rationale

Lean's kernel is binary: a claim is either proven or it carries
`sorry`. In real software, claims live at every stage of maturity
simultaneously — proven on small inputs, tested on fixtures,
trusted environmentally about the OS, sketched as an aspiration.
Collapsing all of these into `theorem` versus `theorem ... := by
sorry` loses information that consumers and future developers
need.

Each macro introduces a named evidence level that the build system
enforces. Promotion (e.g., `TestedConjecture` → `ProvenTheorem`)
is a single keyword change; the build verifies the new level's
requirements are met.

For the working manual for manifest authors, see
`templates/MANIFEST_GUIDE.md`.

## Starting a new project

We ship templates for AI coding agents at `templates/`. Copy
`templates/CLAUDE.md` (for Claude / Anthropic conventions) or
`templates/AGENTS.md` (for the open AGENTS.md convention) to your
project root and customize.

The templates prescribe a workflow that makes manifests usable as
design specs, not just build-time tripwires:

1. Before modifying a function, run `bash Scripts/show-theorems.sh
   PROJECT.functionName` to see what theorems constrain it.
2. After modifying, run `bash Scripts/verify-all.sh`.
3. Annotate new theorems with `@[theorems]` on the function they
   describe.

See `templates/README.md` for details.

## Documentation

| File                                       | What it's about                              |
|--------------------------------------------|----------------------------------------------|
| `templates/MANIFEST_GUIDE.md`              | How to write a good manifest                 |
| `templates/MANIFEST_LATEX_ROUNDTRIP.md`    | Paper appendices with hover-back-to-Lean    |
| `CLAUDE.md`                                | Conventions for working ON lean-manifests itself |

## Status

Active development. Used in production by:

- **`l3m`** — a Lean 4 LLM coding agent with kernel-verified safety
  theorems
- **`lean-stats`** — a pure statistics library validated against R
- **`markdown-cm`** — a CommonMark renderer with conformance proofs
- **`dean_cpp`** — C++ standard library formalization (separate repo)

## License

See LICENSE.
