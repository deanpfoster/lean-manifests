import Lean
import DeanLean.LatexExtract

/-! # DeanLean/LatexRoundtrip.lean — Verify a LaTeX file round-trips

The companion to `LatexExtract`. Given:
  1. A LaTeX file containing `\manifestThm{name}` and
     `\manifestSym{name}{rendered}` markers
  2. A JSON dump from `LatexExtract.run`

This tool verifies:
  * Every `\manifestThm{name}` in the LaTeX resolves to a real
    entry in the JSON dump
  * Every `\manifestSym{name}{...}` resolves to a real entry
  * (Reports as info, not error) entries in the JSON that are
    not referenced anywhere in the LaTeX

Exit code is non-zero if any unresolved markers exist; the
LaTeX build can gate on this.

The "round-trip" guarantee is at the marker level:
  * Every name in the LaTeX corresponds to a real declaration
    in the Lean environment (the JSON is the bridge)
  * The verbatim Lean source is in the JSON's `source_text`
    field, so a LaTeX hover can include it; nothing is lost

The kernel-checkable form of round-trip is: if the LaTeX
verifier passes AND the LaTeX preamble emits the source_text
in `\pdftooltip`, then a reader hovering the marker sees the
exact Lean as it was extracted from the build.

Usage from a project's `Scripts/`:

```lean
import DeanLean.LatexRoundtrip

def main : IO Unit := do
  let argv ← IO.argv
  match argv with
  | #[texFile, jsonFile] =>
    DeanLean.LatexRoundtrip.run texFile jsonFile
  | _ =>
    IO.eprintln "usage: roundtrip <tex-file> <json-file>"
    IO.Process.exit 1
```
-/

set_option autoImplicit false

namespace DeanLean.LatexRoundtrip

open Lean

/-- Markers found in a LaTeX file. -/
structure Markers where
  /-- `\manifestThm{name}` references. -/
  thmRefs : Array String
  /-- `\manifestSym{name}{rendered}` references. -/
  symRefs : Array (String × String)
  deriving Repr

/-- Find a substring's start index from `from`, or none. -/
partial def findFrom (s pat : String) (from_ : Nat) : Option Nat :=
  let patSz := pat.utf8ByteSize
  let sSz := s.utf8ByteSize
  let rec go (i : Nat) : Option Nat :=
    if i + patSz > sSz then none
    else if s.substrEq ⟨i⟩ pat 0 patSz then some i
    else go (i + 1)
  go from_

/-- Read a `{...}` braced argument starting at byte position `pos`
    in `s`. Returns the contents and the byte position after the
    closing brace. Handles balanced braces. -/
partial def readBraced (s : String) (pos : Nat) : Option (String × Nat) :=
  let sSz := s.utf8ByteSize
  if pos ≥ sSz then none
  else if s.get ⟨pos⟩ ≠ '{' then none
  else
    let rec go (i : Nat) (depth : Nat) (acc : String) : Option (String × Nat) :=
      if i ≥ sSz then none
      else
        let c := s.get ⟨i⟩
        if c == '{' then go (i + 1) (depth + 1) (acc.push c)
        else if c == '}' then
          if depth == 1 then some (acc, i + 1)
          else go (i + 1) (depth - 1) (acc.push c)
        else go (i + 1) depth (acc.push c)
    go (pos + 1) 1 ""

/-- Parse all `\manifestThm{...}` and `\manifestSym{...}{...}`
    occurrences from a LaTeX source. -/
def parseMarkers (tex : String) : Markers := Id.run do
  let mut thmRefs : Array String := #[]
  let mut symRefs : Array (String × String) := #[]
  -- \manifestThm{name}
  let mut i := 0
  while true do
    match findFrom tex "\\manifestThm" i with
    | none => break
    | some pos =>
      let after := pos + "\\manifestThm".utf8ByteSize
      match readBraced tex after with
      | none => i := after
      | some (name, next) =>
        thmRefs := thmRefs.push name
        i := next
  -- \manifestSym{name}{rendered}
  let mut j := 0
  while true do
    match findFrom tex "\\manifestSym" j with
    | none => break
    | some pos =>
      let after := pos + "\\manifestSym".utf8ByteSize
      match readBraced tex after with
      | none => j := after
      | some (name, mid) =>
        match readBraced tex mid with
        | none =>
          symRefs := symRefs.push (name, "")
          j := mid
        | some (rendered, next) =>
          symRefs := symRefs.push (name, rendered)
          j := next
  return { thmRefs, symRefs }

/-- Result of round-trip verification. -/
structure Report where
  texFile : String
  jsonFile : String
  resolved : Array String
  unresolved : Array String
  orphans : Array String
  deriving Repr

/-- Render a Report as a human-readable string. -/
def renderReport (r : Report) : String := Id.run do
  let mut out := s!"Round-trip report for {r.texFile} vs {r.jsonFile}:\n"
  out := out ++ s!"  Resolved markers:   {r.resolved.size}\n"
  out := out ++ s!"  Unresolved markers: {r.unresolved.size}\n"
  out := out ++ s!"  Orphan entries:     {r.orphans.size}\n"
  if r.unresolved.size > 0 then
    out := out ++ "\nUNRESOLVED (LaTeX references a name not in the JSON):\n"
    for n in r.unresolved do
      out := out ++ s!"  ✗ {n}\n"
  if r.orphans.size > 0 then
    out := out ++ "\nORPHANS (JSON has entry but LaTeX never references):\n"
    for n in r.orphans do
      out := out ++ s!"  ⚠ {n}\n"
  return out

/-- Run the verifier. Returns non-zero exit if there are
    unresolved markers. -/
def run (texFile jsonFile : String) : IO Unit := do
  let tex ← IO.FS.readFile texFile
  let jsonStr ← IO.FS.readFile jsonFile
  let json ← IO.ofExcept (Json.parse jsonStr)
  let arr ← IO.ofExcept (json.getArr?)
  let knownNames : Std.HashSet String := Id.run do
    let mut s : Std.HashSet String := {}
    for e in arr do
      match e.getObjValAs? String "name" with
      | .ok n => s := s.insert n
      | _ => ()
    return s
  let markers := parseMarkers tex
  let allRefs : Std.HashSet String := Id.run do
    let mut s : Std.HashSet String := {}
    for n in markers.thmRefs do s := s.insert n
    for (n, _) in markers.symRefs do s := s.insert n
    return s
  let mut resolved : Array String := #[]
  let mut unresolved : Array String := #[]
  for n in allRefs.toArray do
    if knownNames.contains n then
      resolved := resolved.push n
    else
      unresolved := unresolved.push n
  let mut orphans : Array String := #[]
  for n in knownNames.toArray do
    if !allRefs.contains n then
      orphans := orphans.push n
  let report : Report := {
    texFile, jsonFile,
    resolved := resolved.qsort (· < ·),
    unresolved := unresolved.qsort (· < ·),
    orphans := orphans.qsort (· < ·)
  }
  IO.println (renderReport report)
  if unresolved.size > 0 then
    IO.eprintln s!"FAILED: {unresolved.size} unresolved markers"
    IO.Process.exit 1

end DeanLean.LatexRoundtrip
