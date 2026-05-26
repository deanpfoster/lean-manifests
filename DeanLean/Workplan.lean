import Lean
import DeanLean.Attr

/-! # DeanLean/Workplan.lean — Reusable workplan generator

For projects using lean-manifests, surfaces UnprovenConjecture
work-in-progress as a structured workplan. Useful for parallel
LLM agents picking up tasks: each agent reads the workplan, picks
an entry point matching its time budget, claims it, works.

The workplan reads three optional attributes on manifest entries
(see `DeanLean/Attr.lean` for definitions):

  * `@[depends_on  foo, bar, baz]`   — what must be done first
  * `@[estimated_minutes 60]`        — rough effort estimate
  * `@[entry_point]`                 — flag: independently approachable

Usage from a project's `Scripts/workplan.lean`:

```lean
import DeanLean.Workplan
import YourProject  -- the namespace you want to enumerate

def main : IO Unit := DeanLean.Workplan.run "YourProject"
```

Run with: `lake env lean --run Scripts/workplan.lean`

The walker only reports `manifest_entry`-tagged constants that:
1. Are in the given namespace
2. Still use sorry transitively (work in progress)
3. Are NOT marked `@[manifest_axiom]` (permanent assumptions, not work)

Once an entry promotes to ProvenTheorem (no sorry) or ManifestAxiom
(intentional), it disappears from the plan. Strip workplan metadata
on promotion to keep entries tidy.
-/

set_option autoImplicit false

namespace DeanLean.Workplan

open Lean

/-- A flattened view of one workplan entry. -/
structure Entry where
  name : Name
  /-- Names this entry depends on (from @[depends_on]). -/
  deps : Array Name
  /-- Time estimate in minutes (from @[estimated_minutes], 0 if unset). -/
  estimateMins : Nat
  /-- True iff @[entry_point] is set. -/
  isEntry : Bool
  deriving Repr

/-- Walk the env, find every const that's a candidate for further
    work in the given namespace, collect its workplan metadata.

    Two kinds of candidates:

    1. **`@[manifest_entry]`-tagged constants** that:
       - Use `sorry` transitively (UnprovenConjecture, TestedConjecture
         awaiting test, DerivedConjecture awaiting axioms)
       - Are NOT tagged `@[manifest_axiom]` (those are permanent
         assumptions, not work; deprecated in favor of WorldClaim)

    2. **`@[sketch]`-tagged constants** — name-grabbers for future
       conjectures. The lifecycle is:
         Sketch (signature + prose, no Prop)
            → UnprovenConjecture (Prop + prose, no proof)
            → ProvenTheorem (Prop + proof)
       Sketches are workplan items: an agent picks one and tries
       to phrase the Prop, then close the proof.

    `WorldClaim`s are NOT in the workplan: they're permanent
    environment-axiomatic gaps, named for the audit surface, not
    pending work. They never close to ProvenTheorem because the
    fact is about the world, not about Lean. -/
def collect (env : Environment) (namespacePrefix : String) : Array Entry := Id.run do
  let mut result : Array Entry := #[]
  for (n, ci) in env.constants.toList do
    let s := n.toString
    if !s.startsWith namespacePrefix then continue
    -- Skip auto-generated companion defs
    if s.contains '_' && (s.endsWith "_check" || s.endsWith "_test") then continue
    -- Pick up Sketches (always) and manifest_entry-tagged unproven (sorry-using).
    let isSketch := hasSketchAttr env n
    let isManifestEntry := manifestEntryAttr.hasTag env n
    let isAxiom := manifestAxiomAttr.hasTag env n
    let usesSorry := ci.getUsedConstantsAsSet.contains ``sorryAx
    let candidate :=
      isSketch ||
      (isManifestEntry && !isAxiom && usesSorry)
    if !candidate then continue
    let deps := (getDependsOn? env n).getD #[]
    let mins := (getEstimatedMinutes? env n).getD 0
    let entry := isEntryPoint env n
    result := result.push { name := n, deps, estimateMins := mins, isEntry := entry }
  return result

/-- Render a Name compactly (last component only). -/
def shortName (n : Name) : String :=
  let s := n.toString
  match s.splitOn "." |>.reverse with
  | last :: _ => last
  | _ => s

/-- Format minutes as "Nm" or "?" if 0. -/
def fmtMins (m : Nat) : String :=
  if m == 0 then "?" else s!"{m}m"

/-- Render a workplan in three buckets:
    1. Entry points: ready to start (entry-point flag, no deps)
    2. Blocked: has unmet deps
    3. Other: no deps but not flagged as entry point -/
def render (entries : Array Entry) : String := Id.run do
  let mut entry : Array Entry := #[]
  let mut blocked : Array Entry := #[]
  let mut other : Array Entry := #[]
  for e in entries do
    if e.isEntry && e.deps.isEmpty then
      entry := entry.push e
    else if !e.deps.isEmpty then
      blocked := blocked.push e
    else
      other := other.push e
  let mut out := s!"WORKPLAN ({entries.size} manifest entries)\n\n"
  let entrySorted := entry.qsort (fun a b => a.estimateMins < b.estimateMins)
  let blockedSorted := blocked.qsort (fun a b => a.estimateMins < b.estimateMins)
  let otherSorted := other.qsort (fun a b => a.estimateMins < b.estimateMins)
  if entrySorted.size > 0 then
    out := out ++ s!"== Entry points (no deps, ready to start) — {entrySorted.size} ==\n"
    for e in entrySorted do
      out := out ++ s!"  {shortName e.name}  est={fmtMins e.estimateMins}\n"
    out := out ++ "\n"
  if blockedSorted.size > 0 then
    out := out ++ s!"== Blocked by other entries — {blockedSorted.size} ==\n"
    for e in blockedSorted do
      let depList := String.intercalate ", " (e.deps.toList.map shortName)
      out := out ++ s!"  {shortName e.name}  est={fmtMins e.estimateMins}  blocked-by: {depList}\n"
    out := out ++ "\n"
  if otherSorted.size > 0 then
    out := out ++ s!"== Other (no deps, no entry-point flag) — {otherSorted.size} ==\n"
    for e in otherSorted do
      out := out ++ s!"  {shortName e.name}  est={fmtMins e.estimateMins}\n"
    out := out ++ "\n"
  return out

/-- Run the workplan: walk the env, collect entries in `namespacePrefix`,
    print the formatted workplan to stdout. The standard entry point. -/
def run (namespacePrefix : String) : IO Unit := do
  searchPathRef.set (← addSearchPathFromEnv {})
  let env ← importModules #[] {}
  let entries := collect env namespacePrefix
  IO.println (render entries)

end DeanLean.Workplan
