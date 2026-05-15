import Lean

/-! # Manifest entry attribute

  The `@[manifest_entry]` attribute marks a declaration as a
  well-behaved conjecture — something declared through one of the
  evidence-hierarchy macros (`UnprovenConjecture`, `TestedConjecture`,
  `DecomposedConjecture`, `DerivedConjecture`, `ProvenTheorem`) in a
  manifest file.

  The enforcement rule: when `DerivedConjecture foo` or
  `DecomposedConjecture foo` is elaborated, every sorry-bearing
  dependency of `foo_derivation` must carry this attribute. A stray
  `theorem x : P := by sorry` sitting in a proof file is not a
  manifest entry, so using it in a derivation is a compile-time error.

  This distinguishes the five "less-apologetic sorrys" of the evidence
  hierarchy from Lean's built-in raw `sorry`. The trust report emitted
  by `DerivedConjecture` is therefore complete: every named dependency
  is a declared manifest entry with a known evidence level, not a
  hidden hole.

  The attribute is applied automatically by the macros in `Basic.lean`.
  Users never write `@[manifest_entry]` by hand.
-/

open Lean

initialize manifestEntryAttr : TagAttribute ←
  registerTagAttribute `manifest_entry
    "marks a declaration as an evidence-hierarchy conjecture entry"

/-- True iff `n` is tagged with `@[manifest_entry]`. -/
def hasManifestEntryAttr (env : Environment) (n : Name) : Bool :=
  manifestEntryAttr.hasTag env n

/-- The `@[manifest_axiom]` attribute marks a declaration as a permanent
    environmental assumption — an axiom we explicitly accept and don't
    expect to ever prove (OS behavior, network reality, hardware semantics,
    source-structure claims).

    Contrast with plain `@[manifest_entry]` UnprovenConjectures, which are
    holes we intend to close eventually.

    In a trust report:
    - ManifestAxiom deps → "fully attested" (as proven as it can be)
    - UnprovenConjecture deps → "partial" (has TODOs) -/
initialize manifestAxiomAttr : TagAttribute ←
  registerTagAttribute `manifest_axiom
    "marks a declaration as a permanent environmental assumption (ManifestAxiom)"

/-- True iff `n` is tagged with `@[manifest_axiom]`. -/
def hasManifestAxiomAttr (env : Environment) (n : Name) : Bool :=
  manifestAxiomAttr.hasTag env n

/-- Attribute marking which theorems describe a function's behavior.
    Usage: `@[theorems thm1, thm2, thm3] def foo := ...`
    The theorems must be ProvenTheorem / TestedConjecture / DerivedConjecture
    that mention `foo` in their statement. -/
syntax (name := theoremsAttr) "theorems" (ident,*) : attr

initialize theoremsExtension : ParametricAttribute (Array Name) ←
  registerParametricAttribute {
    name := `theoremsAttr
    descr := "links a function to theorems that describe its behavior"
    getParam := fun _name stx => match stx with
      | `(attr| theorems $thms,*) => return thms.getElems.map (·.getId)
      | _ => Lean.throwError "invalid theorems attribute"
  }

/-- Get the theorem names associated with a function via `@[theorems ...]`, if any. -/
def getTheorems? (env : Environment) (n : Name) : Option (Array Name) :=
  theoremsExtension.getParam? env n
