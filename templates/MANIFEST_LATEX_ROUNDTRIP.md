# Manifest → LaTeX round-trip (Phase 1)

For producing paper appendices and inline theorem references whose
prose can be authored by an LLM and whose Lean correspondence is
verified at build time.

## The workflow

1. **Author writes prose.** An LLM (or a human) translates a Lean
   manifest theorem into a `\begin{theorem}...\end{theorem}` block
   in LaTeX, marking the theorem's identity and any symbols using
   `\manifestThm{name}` and `\manifestSym{name}{rendered}`. The
   prose itself is unconstrained natural language.

2. **Build extracts entries.** `lake env lean --run
   Scripts/LatexExtract.lean` walks the project's environment and
   dumps every `@[manifest_entry]`-, `@[sketch]`-, or
   `@[world_claim]`-tagged declaration to a JSON file. Each record
   has the qualified name, evidence level + glyph, pretty-printed
   type, doc-comment, source file + line range, and the verbatim
   Lean source text.

3. **Verifier checks round-trip.** `lake env lean --run
   Scripts/LatexRoundtripCLI.lean <tex> <json>` parses the LaTeX
   for `\manifestThm` and `\manifestSym` markers, looks each name
   up in the JSON, and reports:

   - **Resolved**: marker → real Lean entry. ✓
   - **Unresolved**: marker → no such entry. ✗ (build fails)
   - **Orphans**: entry in JSON but never referenced by the LaTeX.
     ⚠ (info only — could be intentional, e.g., a private lemma)

4. **PDF rendering.** The LaTeX preamble (`manifest-discipline.sty`)
   defines the macros to emit `\pdftooltip` calls. Hovering on a
   marker in the rendered PDF shows either the qualified name or
   the verbatim Lean source.

## What round-trips and what doesn't

What's checkable:

- **Marker resolution.** Every name in the LaTeX corresponds to a
  real declaration in the Lean environment.
- **Type signature presence.** When the LaTeX declares
  `\manifestSym{name}{...}[type-hint]`, the verifier can compare
  the hint to the actual signature in the JSON.
- **Verbatim source presence.** Every theorem can fall back to a
  hover that shows the raw Lean — no information loss.

What's NOT checkable:

- **Whether the prose actually means what the Lean says.** That's
  the LLM's job; the round-trip tool only checks structural
  correspondence between markers and entries.
- **Whether two `\manifestSym` calls bind to the same identifier
  consistently.** A future "stylized prose grammar" (Phase 2)
  would add this; Phase 1 leaves it to authorial discipline.

## Files

```
DeanLean/LatexExtract.lean         # walks the env, emits JSON
DeanLean/LatexRoundtrip.lean       # parses LaTeX, verifies markers
Scripts/LatexExtractSmoke.lean     # smoke test on the test corpus
Scripts/LatexRoundtripCLI.lean     # CLI for the verifier
templates/manifest-discipline.sty  # LaTeX macros
templates/example-roundtrip.tex    # worked example
```

## Caveats and known gaps

- **Source-line resolution is heuristic.** The extractor finds the
  unqualified name's first occurrence in the source file and
  widens by ~10 lines. Macro-generated declarations whose name
  doesn't appear verbatim in source give imprecise ranges (e.g.,
  `agentLoop_io_surface_complete` in an auto-generated
  `PureSurfaceData.lean` resolves to line 1).
- **Pretty-printed types are environment-dependent.** Different
  imports may render the same type differently. For paper appendices
  this is fine; for diff-stable round-trip it's a known limitation.
- **PDF tooltips require `pdfcomment`** and a viewer that supports
  them. For HTML/Verso targets, a future Phase 1.5 would emit
  `<span title="...">` or Verso role annotations from the same JSON.

## What Phase 1 buys you

- **Paper appendices that are kernel-grounded.** Every theorem in
  the appendix corresponds to a real declaration; the LaTeX-to-Lean
  bridge is mechanically verified.
- **Per-symbol hover for Greek/math notation.** The reader can
  hover over $\bar{x}$ and see `LeanStats.Stats.mean : Array Float
  → Float`.
- **CI-gateable correctness.** The verifier exits non-zero on
  unresolved markers; a paper's CI can require 0 unresolved before
  building the PDF.

## What Phase 1 does NOT buy you

- True "the prose says what the Lean says" verification. That
  would require a stylized-prose grammar; Phase 2 territory, and
  arguably not worth the readability cost.
- HTML/Verso emission. Same JSON would feed both, but the macros
  for those targets aren't yet written.
- Cross-reference consistency (e.g., flagging when two LaTeX
  symbols bind to different Lean names).

The workflow is described in detail at
`/home/foster/blog/papers/manifest-discipline/draft.md` § (TBD).
