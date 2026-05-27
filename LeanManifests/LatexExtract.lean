import Lean
import LeanManifests.Attr
import LeanManifests.WorldClaim
import LeanManifests.IndexGen

/-! # LeanManifests/LatexExtract.lean — Manifest entries → JSON for LaTeX/HTML/Verso

For Phase 1 of the manifest-to-LaTeX round-trip workflow:

    Lean theorem
      ↓  (LLM, off-line)
    LaTeX prose with \manifestThm{name} and \manifestSym{name}{...} markers
      ↓  (this tool, at build time)
    JSON dump of the manifest environment
      ↓  (LatexRoundtrip.lean)
    Round-trip verification: every marker resolves; types match hints

The extractor walks the environment, collects every `@[manifest_entry]`-
or `@[sketch]`-tagged declaration in a chosen namespace, and emits
a JSON dump per entry:

```json
{
  "name": "LeanStats.mean_empty_zero",
  "evidence_level": "ProvenTheorem",
  "evidence_glyph": "●",
  "type_pp": "mean #[] = 0",
  "doc_string": "Mean of empty array is zero.",
  "source_file": "LeanStats/Stats.lean",
  "source_line_range": [142, 144],
  "source_text": "ProvenTheorem mean_empty_zero :\n  mean #[] = 0",
  "kind": "thm"
}
```

Usage from a project's `Scripts/`:

```lean
import LeanManifests.LatexExtract

def main : IO Unit :=
  LeanManifests.LatexExtract.run "LeanStats" "docs/manifest-index.json"
    #[{ module := `LeanStats }]
```
-/

set_option autoImplicit false

/-- Substring containment via byte-index loop. Returns true iff
    `pat` appears anywhere in `s`. (Not in stdlib in Lean 4.16.) -/
partial def String.containsSubstr (s pat : String) : Bool :=
  if pat.isEmpty then true
  else
    let patSz := pat.utf8ByteSize
    let sSz := s.utf8ByteSize
    let rec go (i : Nat) : Bool :=
      if i + patSz > sSz then false
      else if s.substrEq ⟨i⟩ pat 0 patSz then true
      else go (i + 1)
    go 0

namespace LeanManifests.LatexExtract

open Lean

/-- One manifest entry, ready for serialization. -/
structure Entry where
  name : Name
  evidenceLevel : String
  evidenceGlyph : String
  typePP : String
  docString : String
  sourceFile : String
  sourceLineStart : Nat
  sourceLineEnd : Nat
  sourceText : String
  /-- "thm" | "def" | "axiom" — Lean kind of the underlying decl. -/
  kind : String
  deriving Repr

/-- Classify a manifest entry by evidence level, recognizing all
    macro shapes (ProvenTheorem/UnprovenConjecture/TestedConjecture/
    DerivedConjecture/ManifestAxiom/Sketch/WorldClaim).

    Distinguishes ProvenTheorem from "tested or unproven" by walking
    the value for sorry. We can't easily distinguish UnprovenConjecture
    from TestedConjecture from DerivedConjecture without their
    surrounding macro context, so they collapse to "WithSorry"; the
    paper's appendix reader can refine via the doc-comment. -/
def classifyEntry (env : Environment) (n : Name) : String :=
  if hasSketchAttr env n then "Sketch"
  else if hasWorldClaimAttr env n then "WorldClaim"
  else if hasManifestAxiomAttr env n then "ManifestAxiom"
  else if hasManifestEntryAttr env n then
    match env.find? n with
    | some (.thmInfo val) =>
      if val.value.hasSorry then "WithSorry"
      else "ProvenTheorem"
    | some (.axiomInfo _) => "ProvenTheorem"
    | _ => "Other"
  else "Untagged"

/-- Map evidence level name to its display glyph. -/
def glyphFor : String → String
  | "ProvenTheorem"        => "●"
  | "DerivedConjecture"    => "◕"
  | "DecomposedConjecture" => "◑"
  | "TestedConjecture"     => "◐"
  | "UnprovenConjecture"   => "○"
  | "WithSorry"            => "○"
  | "ManifestAxiom"        => "◆"
  | "Sketch"               => "✎"
  | "WorldClaim"           => "🌍"
  | _                      => "?"

/-- Read a slice of lines from a file, 1-indexed and inclusive. -/
def readLineRange (path : System.FilePath) (lineStart lineEnd : Nat) : IO String := do
  let content ← IO.FS.readFile path
  let lines := content.splitOn "\n"
  let slice := lines.drop (lineStart - 1) |>.take (lineEnd - lineStart + 1)
  return String.intercalate "\n" slice

/-- Pretty-print a Name's type. Pretty-printing requires MetaM,
    which we run inside the surrounding CoreM context. -/
def ppType (env : Environment) (n : Name) : CoreM String := do
  match env.find? n with
  | some ci =>
    let fmt ← Lean.Meta.MetaM.run' (Lean.PrettyPrinter.ppExpr ci.type)
    return fmt.pretty
  | none => return "<not found>"

/-- Best-effort source location: find the file and a small line range
    around the unqualified name. -/
def sourceLocation (env : Environment) (n : Name)
    : IO (Option (System.FilePath × Nat × Nat)) := do
  let some modIdx := env.const2ModIdx.get? n | return none
  let modName := env.allImportedModuleNames[modIdx.toNat]!
  let oleanPath ← try Lean.findOLean modName catch _ => return none
  let oleanStr := oleanPath.toString
  -- Replace .olean with .lean and try the source location.
  let leanStr :=
    if oleanStr.endsWith ".olean" then
      oleanStr.dropRight 6 ++ ".lean"
    else oleanStr
  -- Common case: olean is at .lake/build/lib/Foo.olean and the
  -- source is at Foo.lean. Walk up looking for the source.
  let leanPath := System.FilePath.mk leanStr
  let exists? ← leanPath.pathExists
  unless exists? do
    -- Try replacing ".lake/build/lib/" → ""
    let alt := leanStr.replace ".lake/build/lib/" ""
    let altPath := System.FilePath.mk alt
    let altExists? ← altPath.pathExists
    unless altExists? do return none
    return ← locateInFile altPath n
  locateInFile leanPath n
where
  locateInFile (p : System.FilePath) (n : Name) : IO (Option (System.FilePath × Nat × Nat)) := do
    let content ← IO.FS.readFile p
    let lines := content.splitOn "\n"
    let unqual := n.componentsRev.head?.map Name.toString |>.getD ""
    let mut hit : Option Nat := none
    for h : i in [0 : lines.length] do
      let _ := h
      let line := lines[i]!
      if line.containsSubstr unqual then
        hit := some (i + 1)
        break
    match hit with
    | none => return some (p, 1, 1)
    | some startLine =>
      let mut endLine := startLine
      let drop := lines.drop startLine
      for h : i in [0 : drop.length] do
        let _ := h
        if i ≥ 10 then break
        let line := drop[i]!
        -- stop at a likely declaration boundary
        if line.startsWith "/-" || line.startsWith "@[" then break
        endLine := startLine + i + 1
      return some (p, startLine, endLine)

/-- Build an Entry record for one Name. -/
def buildEntry (env : Environment) (n : Name) : CoreM Entry := do
  let level := classifyEntry env n
  let glyph := glyphFor level
  let typePP ← ppType env n
  let doc := (← Lean.findDocString? env n).getD ""
  let kind :=
    match env.find? n with
    | some (.thmInfo _) => "thm"
    | some (.defnInfo _) => "def"
    | some (.axiomInfo _) => "axiom"
    | some _ => "other"
    | none => "missing"
  let loc ← liftM (sourceLocation env n)
  let (file, sLine, eLine) :=
    match loc with
    | some (f, s, e) => (f.toString, s, e)
    | none => ("", 0, 0)
  let text ← liftM <| do
    if file ≠ "" && sLine > 0 then
      try readLineRange (System.FilePath.mk file) sLine eLine
      catch _ => pure ""
    else pure ""
  return {
    name := n
    evidenceLevel := level
    evidenceGlyph := glyph
    typePP := typePP
    docString := doc
    sourceFile := file
    sourceLineStart := sLine
    sourceLineEnd := eLine
    sourceText := text
    kind := kind
  }

/-- Collect all manifest_entry- and sketch-tagged constants whose
    qualified name starts with `prefix_`. -/
def collectEntries (env : Environment) (prefix_ : String) : Array Name := Id.run do
  let mut out : Array Name := #[]
  for (n, _) in env.constants.toList do
    if !n.toString.startsWith prefix_ then continue
    if hasManifestEntryAttr env n
       || hasSketchAttr env n
       || hasWorldClaimAttr env n then
      out := out.push n
  return out

/-- Render an Entry as a JSON object. -/
def entryToJson (e : Entry) : Json :=
  Json.mkObj [
    ("name", Json.str e.name.toString),
    ("evidence_level", Json.str e.evidenceLevel),
    ("evidence_glyph", Json.str e.evidenceGlyph),
    ("type_pp", Json.str e.typePP),
    ("doc_string", Json.str e.docString),
    ("source_file", Json.str e.sourceFile),
    ("source_line_range",
      Json.arr #[Json.num e.sourceLineStart, Json.num e.sourceLineEnd]),
    ("source_text", Json.str e.sourceText),
    ("kind", Json.str e.kind)
  ]

/-- Top-level entry point: walk the env, build entries, write JSON. -/
def run (namespacePrefix : String) (outPath : String)
    (imports : Array Import := #[]) : IO Unit := do
  searchPathRef.set (← addSearchPathFromEnv {})
  let env ← importModules imports {} 0
  let names := collectEntries env namespacePrefix
  let coreCtx : Core.Context := {
    fileName := "<extract>"
    fileMap := default
  }
  let coreState : Core.State := { env := env }
  let (entries, _) ← (buildAll env names).toIO coreCtx coreState
  let arr := Json.arr (entries.map entryToJson)
  IO.FS.writeFile outPath (arr.pretty)
  IO.println s!"Wrote {entries.size} manifest entries to {outPath}"
where
  buildAll (env : Environment) (names : Array Name) : CoreM (Array Entry) := do
    let mut out : Array Entry := #[]
    for n in names do
      out := out.push (← buildEntry env n)
    return out

end LeanManifests.LatexExtract
