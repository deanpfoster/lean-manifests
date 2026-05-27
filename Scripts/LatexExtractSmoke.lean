import DeanLean.LatexExtract
import DeanLean.Tests.WorldClaimTests
import DeanLean.Tests.SketchTests
import DeanLean.Tests.ManifestTests

/-! # Scripts/LatexExtractSmoke.lean — Smoke test for LatexExtract

Walks the DeanLean.Tests namespace and dumps a JSON file with all
manifest entries it finds. Run:

    lake env lean --run Scripts/LatexExtractSmoke.lean

Expected output:
- `/tmp/dean-lean-manifest-index.json` written
- A summary line like "Wrote N manifest entries to ..."
- The JSON should contain at least one ProvenTheorem and one Sketch
  and one WorldClaim (since the test files use all three).
-/

def main : IO Unit := do
  DeanLean.LatexExtract.run
    "DeanLean.Tests"
    "/tmp/dean-lean-manifest-index.json"
    #[
      { module := `DeanLean.Tests.WorldClaimTests },
      { module := `DeanLean.Tests.SketchTests },
      { module := `DeanLean.Tests.ManifestTests }
    ]
  let content ← IO.FS.readFile "/tmp/dean-lean-manifest-index.json"
  let lines := content.splitOn "\n"
  IO.println s!"Generated JSON has {lines.length} lines"
  -- Print the first few entries for visual inspection
  IO.println "First 30 lines:"
  for line in lines.take 30 do
    IO.println s!"  {line}"
