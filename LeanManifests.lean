import LeanManifests.Basic
import LeanManifests.Attr
import LeanManifests.RegisteredAttr
import LeanManifests.WorldClaim
import LeanManifests.Conformance
import LeanManifests.Conformance.R
import LeanManifests.Conformance.Numpy
import LeanManifests.Conformance.Sql
import LeanManifests.Conformance.Spec
import LeanManifests.Conformance.Script
import LeanManifests.IndexGen
import LeanManifests.Workplan
import LeanManifests.LibraryTame
import LeanManifests.LatexExtract
import LeanManifests.LatexRoundtrip

/-! # LeanManifests: macros and tooling for evidence-tagged claims in Lean 4

The library has five surface layers, listed in load order:

  * `Basic` — the evidence-level macros (`ProvenTheorem`,
    `UnprovenConjecture`, `TestedConjecture`, `DerivedConjecture`,
    `Sketch`, etc.) and the `@[manifest_entry]` attribute.
  * `Attr`, `RegisteredAttr` — attribute infrastructure that the
    macros build on; users normally don't import these directly.
  * `WorldClaim`, `Conformance` — extra macro shapes for
    environment-axiomatic claims and reference-system regression.
  * `IndexGen`, `Workplan`, `LibraryTame`, `LatexExtract`,
    `LatexRoundtrip` — tooling that walks the manifest environment
    to produce trust reports, workplans, audit reports, and
    paper-ready JSON.
  * The meta-manifest under `Manifests/` and `Proofs/Manifests/`
    that documents these macros' own contracts using the macros
    themselves.

Downstream projects typically just `import LeanManifests.Basic` plus
whichever macro shapes they use; the tooling files are imported
separately by build scripts.
-/
