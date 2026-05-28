# Writing a Good Manifest

A manifest is a **living dashboard** for your Lean 4 project. It answers
three questions for three audiences:

- **Consumers** ("Should I depend on this?"): What does this library
  actually promise? What evidence backs those promises?
- **Maintainers** ("What's still TODO?"): Where are the gaps? What's
  proven, what's tested, what's aspirational?
- **Contributors** ("Where can I help?"): Which conjectures are
  approachable entry points? What's blocked on what?

A manifest is NOT a proof obligation list. It's a contract written for
humans, decorated with machine-checkable evidence levels.

---

## 1. The shape of a good top-level `Manifest.lean`

Your project's root `Manifest.lean` should contain **4–6 headline
claims** — the load-bearing promises your library makes. Write them
for the consumer, not for yourself.

Structure:

```lean
import LeanManifests.Basic
import YourProject.Manifests.Axis1
import YourProject.Manifests.Axis2

/-! # YourProject — Manifest

What this library promises:
1. <plain English description of claim 1>
2. <plain English description of claim 2>
...

## What we do NOT claim

- <explicit boundary 1>
- <explicit boundary 2>
-/

-- Claim 1: one-line English summary
-- Evidence: TestedConjecture (N/M examples passing)
Restate YourProject.Manifests.Axis1.headline_claim_1

-- Claim 2: one-line English summary
Restate YourProject.Manifests.Axis2.headline_claim_2
...
```

Key principles:

- **"What we do NOT claim" is mandatory.** Consumers need to know
  boundaries. If you don't claim full CommonMark compliance, say so.
  If you don't claim thread safety, say so.
- **4–6 claims, not 40.** The top-level manifest is an executive
  summary. Detail lives in per-axis files.
- **Plain English headers above each claim.** The Lean type is the
  formal statement; the comment is for humans who don't read Lean.

The canonical example is markdown-cm's `MarkdownCM/Manifest.lean`:
a handful of headline claims (conformance, termination, roundtrip
stability), an explicit "What we do NOT claim" section (no HTML
sanitization, no extensions), and `Restate` pulling from per-axis
manifests.

---

## 2. Per-axis decomposition

When your project is large enough to have multiple independent
concerns, split into `Manifests/<Axis>.lean` files. Each axis is a
single concern with its own claims and evidence.

Example axes (from markdown-cm):

| File | Concern |
|------|---------|
| `Manifests/Conformance.lean` | Spec compliance per section |
| `Manifests/Termination.lean` | Parser always terminates |
| `Manifests/Roundtrip.lean` | Parse→render→parse stability |
| `Manifests/Renderer.lean` | Output well-formedness |

Benefits:

- Each axis can progress independently (conformance at 60% while
  termination is fully proven).
- Contributors can focus on one axis without understanding the others.
- The top-level manifest stays readable by restating only headlines.

When to decompose: if you have more than ~8 claims, or if claims
naturally cluster into independent concerns. A 3-claim project
doesn't need decomposition — a single `Manifest.lean` is fine.

The top-level manifest imports each axis and uses `Restate` to pull
in the headline claim from each. This keeps the top-level file short
and navigable while the detail lives where it belongs.

---

## 3. Showing live progress with `registerTestResults`

This is the killer pattern. Decorate conjectures with live test
counts so anyone reading the manifest sees progress without building:

```lean
-- CommonMark §4.1: ATX headings
-- 19 of 22 spec examples passing
registerTestResults atx_headings_conformance (passed := 19) (total := 22)
@[entry_point, estimated_minutes 30]
UnprovenConjecture atx_headings_conformance :
  ∀ (input expected : String),
    input ∈ atxHeadingExamples →
    render (parse input) = expected
```

What this gives each audience:

- **Consumer**: "ATX headings are 86% conformant — good enough for
  my use case" (or not).
- **Maintainer**: "3 examples still failing — that's the next task."
- **Contributor**: "This is an entry point, estimated 30 minutes,
  and I can see exactly what's left."

The gap between `passed` and `total` IS the work-in-progress. No
separate tracking system needed.

Update `registerTestResults` whenever you fix a test. The numbers
in the manifest are the source of truth for progress. When all tests
pass, promote to `TestedConjecture` and the numbers become a
permanent record of coverage breadth.

---

## 4. Workplan attributes

For parallel agent work, decorate `UnprovenConjecture` entries (and
`Sketch` entries — see below) with scheduling metadata from
`LeanManifests.Workplan`:

```lean
@[entry_point]                    -- independently approachable
@[estimated_minutes 45]           -- rough effort budget
@[depends_on parse_paragraphs]    -- blocked until this is done
UnprovenConjecture parse_lists_conformance : ...
```

- `@[entry_point]`: no unmet dependencies; an agent can start here.
- `@[estimated_minutes N]`: rough time budget for the task.
- `@[depends_on x, y]`: blocked until `x` and `y` are promoted.

**Strip all workplan metadata on promotion.** Once a conjecture
becomes `TestedConjecture` or `ProvenTheorem`, the scheduling info
is noise. Remove it.

The workplan picker (`LeanManifests.Workplan.collect`) surfaces:

  * `@[manifest_entry]` constants that still use `sorry` transitively
    (UnprovenConjectures, TestedConjectures awaiting tests, etc.)
  * **`@[sketch]` constants** — name-grabbers waiting for a Prop.

It does NOT surface `WorldClaim`s. Those are permanent
environment-axiomatic gaps, not pending work — they will never
close to ProvenTheorem because the fact is about the world, not
about Lean.

The lifecycle:

```
Sketch  (signature + prose, no Prop)
   ↓ when language exists to phrase the Prop
UnprovenConjecture  (Prop + prose, no proof)
   ↓ when proof closes
ProvenTheorem  (Prop + proof)
```

Sketches that will never become real (because they describe
something Lean can't model) belong as **WorldClaim** instead —
which forces you to phrase the Prop and the falsifying
observation, but doesn't enter the workplan. If you can't phrase
the falsifying observation, you don't yet understand what you're
assuming, and the macro now hard-errors on a WorldClaim without
a doc-comment.

Run `lake env lean --run Scripts/Workplan.lean` to see the current
state: entry points ready to claim, blocked items, and untagged work.

---

## 5. Anti-patterns to avoid

### 5a. Vacuous totality

**Bad:**
```lean
UnprovenConjecture parse_total :
  ∀ (s : String), ∃ (d : Document), parse s = d
```

This is trivially true for ANY function — even a diverging one.
The existential `∃ d, f x = d` says nothing about termination,
correctness, or behavior. It's a tautology disguised as a claim.

**What to do instead:**

- Rely on Lean's structural-recursion checker. If your `def` compiles
  without `partial`, Lean has already proven termination. Don't
  restate what the kernel gives you for free.
- If you must use `partial def`, document WHY (e.g., "input is
  streaming; termination depends on external EOF") and test with
  adversarial inputs.
- If you want to claim totality, prove something with real shape:
  `parse s` returns a `Document` satisfying specific structural
  properties, not just that it returns *something*.

**The strongest pattern: `native_decide` over a documented adversarial corpus.**

Curate a list of inputs known to trip naive parsers (long delimiter
chains, deep brackets, escape pathologies, large UTF-8 sequences,
etc.). Run them through your function as a Bool result. Prove the
Bool with `native_decide`:

```lean
-- Tests/Stress.lean
def stressInputs : List String := [
  "*".replicate 10000,        -- emphasis chains
  "[".replicate 10000,        -- nested links
  String.mk (List.replicate 1000 '\\'),  -- escape chains
  -- ... 11 more curated cases
]

def runStressTestsPure : Bool :=
  stressInputs.all fun s => (parse s).blocks.length ≥ 0
  -- non-trivial predicate that requires parse to produce a result

-- Manifests/Termination.lean
ProvenTheorem terminates_on_adversarial_inputs :
  Tests.Stress.runStressTestsPure = true := by native_decide
```

What this gives you:

- **Real evidence.** The kernel actually runs `parse` on the corpus
  at build time. If `parse` diverges on any input, `native_decide`
  hangs and the build fails.
- **Honest scope.** The claim is "terminates on these N specific
  cases the corpus author thought were pathological," not "terminates
  on all inputs." When you find new pathologies, grow the corpus and
  the proof regenerates.
- **Composes with regression testing.** Adding a stress case is one
  line; the proof updates automatically; the build catches future
  regressions.
- **Build-cost is bounded.** A few seconds of `native_decide` evaluation
  is fine; ten thousand cases would not be. Tune corpus size.

This is stronger than option 2 (TestedConjecture with stress test)
because the kernel runs the test as part of proof checking. It's
honest where option 3 (informal documentation) is hand-wavy.

Originated from markdown-cm's solution to the same problem we're
warning about here (its first version had the vacuous totality
shape). The cleaner version is now the recommended pattern.

### 5b. Trivially decidable claims left as UnprovenConjecture

**Bad:**
```lean
UnprovenConjecture canonicalize_empty : canonicalize "" = ""
```

If `canonicalize` is a non-`partial` function that reduces on `""`,
this is provable by `decide` or `native_decide`. Leaving it as
`UnprovenConjecture` is noise — it signals "we haven't verified this"
when in fact the kernel can verify it in milliseconds.

**Rule:** If `decide` works, use `ProvenTheorem`. If it doesn't work
(timeout, universe issues), explain why in a comment and leave as
`TestedConjecture` with a concrete witness.

### 5c. True-typed conjectures

The extreme case of 5b: a conjecture whose type is `True` or is
trivially inhabited. This was caught by our earlier cleanup discipline
(the `True`-typed audit). Mention it here for completeness: if your
claim's type is trivially provable by `trivial`, it's not a claim.

### 5d. Sorry'd ProvenTheorems

**Bad:**
```lean
ProvenTheorem foo : P := by sorry
```

A `ProvenTheorem` with `sorry` is a lie. The macro should reject this
at elaboration time (and does, if you're using the current version of
lean-manifests). But if you're tempted to "temporarily" sorry a
ProvenTheorem — don't. Use `UnprovenConjecture` for unproven claims.
Promote when proven. The evidence level IS the status.

### 5e. UnitTest vs. Theorem: the proof method tells you which

A common temptation is to downgrade a no-`∀` claim to `UnitTest`:

```lean
-- "no forall, so it must be a unit test"
UnitTest mean_empty :
  mean #[] = 0
```

That heuristic is **wrong about 5% of the time** and the failure modes
are nasty. The correct line:

  * **`UnitTest`** = "run the code on this fixture and check the
    output." Proof is `native_decide` (or `rfl` for trivially-equal
    values). The proof effort is bounded by how long the function
    takes to run on the fixture. **Cheap.**

  * **`ProvenTheorem`** = "this property holds, here's a structural
    argument." Proof is anything that's NOT just running the code:
    `simp [unfold]`, `induction`, case analysis, named lemmas. The
    proof IS the value-add; it gives you stronger guarantees than
    any single fixture.

The tell that you've miscategorized: `native_decide` is slow, fails
to synthesize `Decidable`, or runs out of heartbeats. When that
happens, the function is doing too much work to be a unit test —
either:

  (a) The body equates values of a custom inductive type without
      `DecidableEq`. The `UnitTest` macro can't synthesize the
      decidability instance; the body's `_proof = rfl` would have
      worked. Promote back to `ProvenTheorem`.
  (b) The `native_decide` triggers symbolic evaluation of a large
      data structure (e.g., `List.replicate 12000 'a'`) and hangs
      for minutes. The claim is structural, not fixture-shaped;
      the proof should reduce to a small lemma over `truncateForLlm`
      (or whatever the truncation function is) plus `simp`.
      Promote to `ProvenTheorem`, write a real proof.

**Decision rule (95% of cases):**

```
no ∀, body uses only types with DecidableEq, native_decide finishes
in < 1 sec  →  UnitTest

anything else  →  ProvenTheorem (or UnprovenConjecture if the proof
                  doesn't exist yet)
```

**Watch out for:** custom inductive types (`AgentAction`, `ReviewVerdict`,
your own structures). Unless they `deriving DecidableEq`, equality on
them will fail `native_decide`'s synthesis check. The original `_proof`
form using `rfl` works because `rfl` doesn't need `Decidable` — but the
`UnitTest` macro requires it.

**Anti-pattern: bulk-downgrade by syntactic heuristic.** Auditing 280
ProvenTheorems with a "no ∀ → downgrade" rule will produce ~95%
correct conversions but the remaining 5% will silently break the
build (often only on a clean rebuild — see the "library vs binary"
note in the verify-all.sh script). Run `lake build L3m` after any
bulk downgrade.

---

## 6. Promotion discipline

Claims move through evidence levels as work progresses:

```
UnprovenConjecture     — writing the implementation
       ↓
FailingConjecture      — tests registered, some failing
       ↓
TestedConjecture       — 100% of registered tests pass
       ↓
ProvenTheorem          — kernel-checked proof (no sorry)
```

Guidelines:

- **Start at `UnprovenConjecture`** while the feature is being
  implemented. Add `@[entry_point]` and `@[estimated_minutes]` if
  you want agents to pick it up.
- **Add `registerTestResults` early.** Even `passed := 0` is useful —
  it shows the claim is being actively worked.
- **Use `FailingConjecture`** when some tests pass but not all. This
  is honest: "we're making progress but aren't there yet."
- **Promote to `TestedConjecture`** when all registered tests pass.
  This requires a `_test` witness in scope.
- **Promote to `ProvenTheorem`** when you have a kernel-checked proof.
  This is rare for IO-bound properties (you can't prove the OS
  behaves correctly) but common for pure functions.
- **On promotion, strip workplan metadata.** Remove `@[entry_point]`,
  `@[estimated_minutes]`, `@[depends_on]`. The work is done.

Never skip levels to look good. A `TestedConjecture` with 5 concrete
witnesses is more honest than a `ProvenTheorem` you're not sure about.

---

## 7. Documentation hygiene

### Comments are for humans

```lean
-- Claim: parsing any valid ATX heading produces exactly one
-- Heading node with the correct level (1-6).
-- Why: this is the most basic structural guarantee consumers need.
TestedConjecture atx_heading_structure : ...
```

- The `--` comment above a claim explains WHAT it says in plain
  English and WHY it matters.
- Use `--` line comments, not `/-- -/` docstrings. The
  `UnprovenConjecture` macro doesn't accept attached docstrings
  (known limitation).

### Headers organize the manifest

Use `/-! ... -/` module docstrings for section headers:

```lean
/-! ## Conformance: Block-level elements -/

-- ATX headings (§4.1)
registerTestResults ...
TestedConjecture atx_conformance : ...

/-! ## Conformance: Inline elements -/
...
```

### Explain design evolution

When a claim's formulation changes, leave a comment explaining why:

```lean
-- Earlier formulation was `∀ s, parse s ≠ none` which is vacuous
-- (parse always returns Something). Replaced with structural claim.
TestedConjecture parse_produces_valid_ast : ...
```

This prevents future contributors from reverting to the bad
formulation.

### Cross-rung pointers (every file points up)

A reader who lands on a file should be able to find a less
detailed version of the same content with one cursor jump. This
gives manifest discipline a *bidirectional* shape: the kernel
checks the proofs (formal); the cross-pointers organize the
prose (navigational).

The rungs of the ladder, from most detailed to least:

```
implementation file (LeanStats/Plot/Theme.lean)
   ↑ "See LeanStats.Manifests.Plot for the contract."
area manifest (LeanStats.Manifests.Plot)
   ↑ "See LeanStats.Manifest for the library overview."
top-level library manifest (LeanStats.Manifest)
   ↑ "See ../README.md for what this library is for."
README.md
```

Every file's module docstring should name the rung above it:

```lean
/-! # LeanStats.Plot.Theme — switchable visual themes

Themes control colors, weights, fonts, spacing.

For the structural claims about visualization output (SVG
namespace, data-id counts, theme-CSS distinctness), see
`LeanStats.Manifest` § 6 ("Interactive visualization"). -/
```

```lean
/-! # LeanStats.Manifests.Plot — claims about the plot module

Structural and conformance claims about the plot generators in
`LeanStats/Plot/`.

For the library overview and the cross-cutting promises
(purity, safety on degenerate inputs, R-conformance), see
`LeanStats.Manifest`. -/
```

```lean
/-! # LeanStats + LeanTab — Manifest

A pure Lean 4 library for statistics, data manipulation, and
interactive visualization.

For what the library is for and who should use it, see the
project `README.md`. -/
```

The README is the ground floor. It's where someone deciding
whether to adopt the library lands. Every climb upward
eventually terminates there.

#### Why this works

A reader who jumps to an implementation file (say, by following
a stack trace or a search result) usually wants more context but
doesn't know where to find it. Without pointers, they read the
implementation file's source and infer the contract. With
pointers, they climb one rung and read the contract directly.

The discipline crosses project boundaries naturally: a sibling
project's reader follows the same ladder. The pattern's value
multiplies when both sides adopt it.

#### Per-function pointers vs per-file pointers

These complement each other:

  * **`@[theorems thmName]` on a function** — points from a
    function to the specific theorem(s) constraining it.
    Surfaced by `Scripts/show-theorems.sh`.
  * **Module-doc pointer at the top of the file** — points from
    a *file* to its *area manifest* and (transitively) to the
    library top.

The function-level annotation is for someone modifying the
function ("which theorems do I need to preserve?"). The
file-level pointer is for someone reading the file from cold
("where's the contract for this module?"). Both belong; neither
replaces the other.

#### When to skip a pointer

Some files don't have a manifest pointer to write:

  * Pure utility files that no manifest claims about (e.g., a
    one-function helper used only internally).
  * Generated code (machine-written; the upstream generator's
    docstring is the right place to put the pointer).
  * Test fixtures (the test file's docstring already names the
    test, no further climb needed).

For everything else — every implementation file whose theorems
appear in the trust report, every manifest file, every
generated index — there should be a pointer.

#### When the README points elsewhere

The README is the ground floor for *integrators and adopters*.
For a *deep contributor* the README's pointers go elsewhere:
to `Architecture.lean` (or equivalent), to design docs, to the
trust-baseline. Both audiences are served. The README is not
the last word; it's the first word.

---

## Quick checklist

Before committing a manifest change:

- [ ] Top-level has 4–6 headline claims, not a dump of everything
- [ ] "What we do NOT claim" section is present and honest
- [ ] Every `UnprovenConjecture` either has workplan metadata or a
      comment explaining why it's deferred
- [ ] No vacuous totality claims (`∀ x, ∃ y, f x = y`)
- [ ] No trivially-decidable claims left as UnprovenConjecture
- [ ] `registerTestResults` numbers are current
- [ ] Promoted claims have workplan metadata stripped
- [ ] Plain English comments above each claim
- [ ] **Module-doc pointer to the file's area manifest, top-level
      manifest, or README — every file points one rung up**

---

## 5. Spec-driven manifests

The patterns above tell you how to *write* a valid manifest. The
patterns in this section tell you how to write a manifest that's
*genuinely consulted* — one a debugger reaches for before the
source code, and one detailed enough that a parallel implementer
could re-implement the module without coordination.

These are derived from a spec-first design exercise on a Lean
linenoise-equivalent (paste handling, line editing, terminal mode);
see `~/l3m.kiro/L3m/Manifests/Linenoise.lean` and
`~/l3m.kiro/docs/spec-driven-manifests.md` for the full rationale.

### 5a. Theorem names are first-class API

Outcome-shaped names track with how someone debugging searches:

- **Good**: `paste_block_arrives_as_one_event_when_brackets_present`
- **Good**: `fromWorkspace_post_confine_blocks_git`
- **Good**: `unterminated_paste_yields_parseError`
- **Bad**: `parse_correct`, `confine_within_root`, `buffer_advances_cursor`

Names like `parse_correct` describe what the function does;
names like `paste_arrives_as_one_event` describe what the user
sees. Use the latter when possible.

### 5b. Number layers explicitly when code has them

If the module has clear layers (e.g., pure → IO → audit-grep, or
terminal → multiplexer → middleware → kernel → libc → parser),
label them L1, L2, ... in the module doc and tag each theorem
with its layer. Debugging is a layer walk; the labels make it
navigable.

### 5c. Falsifying observations on every axiom

Each `ManifestAxiom` includes a doc-comment naming the test that
would prove it false:

```lean
ManifestAxiom axiom_decset_2004_brackets_pastes : True
-- Falsifying observation: enable in cat-xxd test, paste, look
-- for markers.
```

Without this, axioms read as ghosts. With it, they're testable
hypotheses with documented test plans.

### 5d. Negative-case theorems

Every "X is rejected" theorem deserves a paired "X-lookalike is
NOT rejected." Without negatives, the theorem proves the
rejection works but not that it doesn't overreach.

```lean
ProvenTheorem isSafeForMutation_rejects_git
ProvenTheorem isSafeForMutation_accepts_lookalikes
  -- .gitignore, .git_old, "git" the file, etc.
```

### 5e. Worked-example completeness checks

Add a section of `completeness_check_*` theorems whose statements
are concrete inputs paired with concrete expected outputs. A
reader can compute the expected output for each and compare.
Without these, two implementations may diverge on inputs the spec
didn't think to constrain.

```lean
ProvenTheorem completeness_check_simple_paste :
  parse (pasteStart ++ "hello" ++ pasteEnd) = [.paste "hello", .eof]
```

### 5f. Distinguish stream-during from EOF

Don't conflate "what does the parser do during a stream" with
"what does it do when the stream ends." Two functions:
`parsePartial : State → Bytes → State × Events` and
`parseAtEof : State → Events`. Theorems say which one they're
about. Generalizes: any IO-stateful protocol has a stream phase
and a closing phase; the spec must distinguish.

### 5g. Chunk-invariance for streaming

The single most important compositionality theorem for any
streaming protocol:

```lean
ProvenTheorem parser_chunk_invariant :
  ∀ chunk₁ chunk₂, parsePartial (chunk₁ ++ chunk₂)
    = (parsePartial chunk₁; parsePartial chunk₂)
```

Without this, parser and reader can be independently correct but
together produce wrong results.

### 5h. Mark "intentionally not specified"

ManifestAxioms can name choices left to implementations:

```lean
ManifestAxiom parseError_message_is_implementation_defined : True
-- The error kind is fixed; the human-readable message text may vary.
```

Stating underdetermination explicitly prevents parallel implementers
from accidentally agreeing on irrelevant details, or from disagreeing
on relevant ones.

### 5i. Mark the FFI / IO boundary explicitly

Sections that cross out of Lean (into syscalls, libraries, OS,
foreign programs) get a meta-section saying so. Each
ManifestAxiom in those sections gets a tag:

- `[in-process]` — testable from inside Lean (graduates to
  TestedConjecture as the project matures)
- `[out-of-band]` — testable but needs strace/xxd/sibling-process
- `[external]` — about a foreign system; behavior may change

The Lean-pure layer can carry the strong form ("any passing
implementation is interchangeable"). FFI layers carry weaker
guarantees. Marking the boundary makes the gradient clear.

### 5j. Disproven conjectures (cautionary tales)

When implementation reveals an assumption was wrong, record the
disproof rather than silently updating the manifest. Currently no
macro support, so write as a doc-tagged comment:

```lean
-- DISPROVEN 2026-05-21:
-- TheoremThatWouldHaveBeen :
--   ∀ env, decset_2004_emitted env → markers_arrive_at_binary env
--
-- Disproof: hex log via L3M_DEBUG_STDIN showed lines arriving
-- without markers despite tmux/terminal being configured.
-- Resolution: disabled readline's bracketed-paste in wrapper.
```

The pattern serves debug-by-manifest: if you read a disproof
matching your symptom, the answer is already documented.

If this pattern earns its keep across several manifests, promote
to a proper `DisprovenConjecture` macro in lean-manifests with
the same elaborator shape as `ProvenTheorem` but emitting a doc
entry not a theorem.

---

## 6. The complete-by-construction goal

When all rules above are followed, the Lean-pure layer of a
manifest aims to be **complete** in this sense:

> Any two implementations that pass all theorems are
> observationally indistinguishable.

We never quite reach this for the FFI layer (depends on foreign
systems). We can reach it for parsers, line editors, history,
buffer arithmetic, and similar pure modules.

The cost is real: spec-to-code ratio of roughly 1:1 for code
specified to this depth. The benefit: implementation becomes
mechanical. Multiple agents can implement the same spec without
coordination and produce interchangeable artifacts.

