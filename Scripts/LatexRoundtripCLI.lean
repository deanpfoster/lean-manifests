import DeanLean.LatexRoundtrip

/-! # Scripts/LatexRoundtripCLI.lean — CLI for the round-trip verifier

Run: `lake env lean --run Scripts/LatexRoundtripCLI.lean <tex> <json>`

Exit code 0: all markers resolve.
Exit code 1: at least one marker is unresolved.
-/

def main (args : List String) : IO UInt32 := do
  match args with
  | [texFile, jsonFile] =>
    DeanLean.LatexRoundtrip.run texFile jsonFile
    return 0
  | _ =>
    IO.eprintln "usage: lake env lean --run Scripts/LatexRoundtripCLI.lean <tex-file> <json-file>"
    return 2
