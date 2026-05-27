import LeanManifests.LatexExtract
import LeanManifests.Tests.WorldClaimTests
import LeanManifests.Tests.SketchTests
import LeanManifests.Tests.ManifestTests

/-! # Scripts/LatexExtractSmoke.lean — Smoke test for LatexExtract

Walks the LeanManifests.Tests namespace and dumps a JSON file with all
manifest entries it finds. Run:

    lake env lean --run Scripts/LatexExtractSmoke.lean

Expected output:
- `/tmp/dean-lean-manifest-index.json` written
- A summary line like "Wrote N manifest entries to ..."
- The JSON should contain at least one ProvenTheorem and one Sketch
  and one WorldClaim (since the test files use all three).
-/

def main : IO Unit := do
  LeanManifests.LatexExtract.run
    "LeanManifests.Tests"
    "/tmp/dean-lean-manifest-index.json"
    #[
      { module := `LeanManifests.Tests.WorldClaimTests },
      { module := `LeanManifests.Tests.SketchTests },
      { module := `LeanManifests.Tests.ManifestTests }
    ]
  let content ← IO.FS.readFile "/tmp/dean-lean-manifest-index.json"
  let lines := content.splitOn "\n"
  IO.println s!"Generated JSON has {lines.length} lines"
  -- Print the first few entries for visual inspection
  IO.println "First 30 lines:"
  for line in lines.take 30 do
    IO.println s!"  {line}"
