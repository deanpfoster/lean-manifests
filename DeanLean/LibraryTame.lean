import Lean
import DeanLean.Basic

/-! # DeanLean.LibraryTame — content-audit of a library's reachable surface

`LibraryTame` is a structural audit of every constant reachable
from a set of named entry points. It checks that the library
contains no:

  - `initialize` blocks (run arbitrary IO at module load)
  - `@[extern]` declarations outside an explicit allow-list
    (custom externs run arbitrary native code from C/Rust/…)
  - Raw `axiom` declarations outside Lean's standard set
    (`Classical.choice`, `propext`, `Quot.sound`) and outside
    the project's @[manifest_axiom]-tagged set
  - `unsafe def` declarations (skip the kernel's safety checks)

This is the structural counterpart to `PureExcept` (which checks
IO leaks specifically) and `AxiomsAllowed` (which checks the
axiom surface specifically). `LibraryTame` is "everything that
matters about a library's tameness, in one shot, for one named
entry-point bundle."

## Why not check IO too?

`PureExcept` already has a more-targeted IO surface check. A
library can have controlled IO (e.g., a logger that writes to
stderr) and still be tame in the structural sense — what
`LibraryTame` certifies. The two macros compose: a library
tagged `LibraryTame` AND `PureExcept` (modulo a small allow-list)
is structurally and semantically clean.

## Why not require a content hash now?

The memo (docs/design/incubated-extraction.md) calls for
content-addressed audit theorems — `<lib>_<hash>_tame` so `git
mv` between phases doesn't invalidate the audit. That's
implementable but requires file IO at elaboration time (read
sources, hash them) which Lean's elaboration doesn't have
trivially. Phase 1 (this commit) ships the structural check and
emits a name-only theorem (`<root>_library_tame`); Phase 2 can
add hash-keying when an actual extracted library wants the
git-mv-stable property.

## Usage

```lean
import DeanLean.LibraryTame

LibraryTame LeanStats.Manifest allows extern_lean_uint_to_string
```

Reads as: starting from `LeanStats.Manifest`, walk every
reachable constant. The audit passes if the only externs are in
the allow-list, and if there are no initialize / unsafe def /
unexpected axioms anywhere.

If it compiles, the library is tame. If not, the build fails
with the names of every offender, sorted by category.

## Trust posture

Pure structural check at elab time. Reads `Environment.find?`
data only. No IO during elaboration. Mirrors `PureExcept` and
`AxiomsAllowed` in approach.
-/

set_option autoImplicit false

namespace DeanLean

open Lean Elab Command

/-- One category of violation `LibraryTame` can report. -/
inductive LibraryTameViolation where
  | initialize (n : Name)
  | unsafeDef (n : Name)
  | rawExtern (n : Name)
  | unexpectedAxiom (n : Name)
  deriving Repr

/-- Render a violation for the build error message. -/
def LibraryTameViolation.render : LibraryTameViolation → String
  | .initialize n      => s!"  initialize:    {n}"
  | .unsafeDef n       => s!"  unsafe def:    {n}"
  | .rawExtern n       => s!"  @[extern]:     {n}"
  | .unexpectedAxiom n => s!"  axiom:         {n}"

/-- Walk reachable constants from `root` (uses `getUsedConstantsAsSet`,
    same as `PureExcept` / `AxiomsAllowed`). -/
private partial def reachableFromLibrary (env : Environment) (root : Name) : NameSet :=
  go (NameSet.empty) root
where
  go (visited : NameSet) (n : Name) : NameSet :=
    if visited.contains n then visited
    else
      let visited := visited.insert n
      match env.find? n with
      | none => visited
      | some info => info.getUsedConstantsAsSet.fold go visited

/-- Standard Lean axioms that every project relies on. -/
private def standardAxioms : NameSet :=
  NameSet.empty
    |>.insert ``Classical.choice
    |>.insert ``propext
    |>.insert ``Quot.sound

/-- Inspect a single constant for tameness violations. The
    `inScopeNs` filter restricts which constants get checked for
    extern-ness: only constants whose name is under one of the
    given namespaces are flagged. Lean's stdlib extern (Nat.add,
    String.length, etc.) are pre-existing trust assumptions —
    LibraryTame is about THIS library's own structural cleanness,
    not about the language platform's. -/
private def inspectConstant (env : Environment) (allowedExterns : NameSet)
    (inScopeNs : Array Name) (n : Name) :
    Array LibraryTameViolation := Id.run do
  match env.find? n with
  | none => return #[]
  | some info =>
    let mut viols : Array LibraryTameViolation := #[]
    -- Only flag IN-SCOPE constants for structural violations.
    -- Externs / unsafe / init / unexpected axioms in stdlib are
    -- not our concern; those are trust boundaries inherited from
    -- the platform.
    let inScope := inScopeNs.isEmpty ||
      inScopeNs.any (fun ns => ns.isPrefixOf n)
    if !inScope then return viols
    -- 1. initialize blocks
    if (Lean.getInitFnNameFor? env n).isSome then
      viols := viols.push (.initialize n)
    -- 2. unsafe defs
    if info.isUnsafe then
      viols := viols.push (.unsafeDef n)
    -- 3. extern declarations outside allow-list
    if (Lean.getExternAttrData? env n).isSome && !allowedExterns.contains n then
      viols := viols.push (.rawExtern n)
    -- 4. axioms outside standard + allowed set
    match info with
    | .axiomInfo _ =>
      if !standardAxioms.contains n && !allowedExterns.contains n then
        if !hasManifestAxiomAttr env n then
          viols := viols.push (.unexpectedAxiom n)
    | _ => pure ()
    return viols

/-- The audit. Walks reachable constants from `root`, accumulates
    violations, fails if any.

    Usage:
      LibraryTame Foo.Bar allows extern1 extern2 ...

    `allows` lists names that are exempt from the extern check
    (for FFI we explicitly trust). The standard kernel axioms
    (Classical.choice, propext, Quot.sound) are always allowed.
    `@[manifest_axiom]`-tagged axioms are also allowed (they're
    the project's explicit environmental assumptions).

    The structural check is scoped to constants under the root's
    enclosing namespace. So `LibraryTame Foo.Bar.smokeRoot` will
    flag externs / unsafe / init / unexpected axioms in `Foo.Bar.*`
    but NOT in stdlib (`Nat.*`, `String.*`, etc.) — stdlib externs
    are the platform's trust base, not this library's. -/
elab "LibraryTame " root:ident " allows " allowed:ident* : command => do
  let rootName := root.getId
  let allowedSet : NameSet := allowed.foldl (init := .empty) fun s id => s.insert id.getId
  let env ← getEnv
  match env.find? rootName with
  | none => throwError s!"LibraryTame: root '{rootName}' not found"
  | some _ =>
    -- If root is at top level (e.g. `def auditRoot`), use the root
    -- itself as the scope marker — the audit covers the root's own
    -- definition only. Otherwise use the root's enclosing namespace
    -- so any `Foo.Bar.X` constant is in scope when auditing `Foo.Bar.Y`.
    let parentNs := rootName.getPrefix
    let inScope : Array Name :=
      if parentNs == .anonymous then #[rootName]
      else #[parentNs]
    let reachable := reachableFromLibrary env rootName
    let mut allViolations : Array LibraryTameViolation := #[]
    for c in reachable do
      if c.toString.startsWith "_private." then continue
      allViolations := allViolations ++ inspectConstant env allowedSet inScope c
    if allViolations.isEmpty then
      let thmName := Lean.mkIdent (rootName.appendAfter "_library_tame")
      elabCommand (← `(@[manifest_entry] theorem $thmName : True := trivial))
      logInfo m!"LibraryTame {rootName}: ✓ {reachable.size} reachable constants, no violations in {parentNs}.*"
    else
      let lines := allViolations.map LibraryTameViolation.render
      let body := String.intercalate "\n" lines.toList
      throwError s!"LibraryTame {rootName}: {allViolations.size} violations in {parentNs}.*\n{body}\n\nIf any of the externs / axioms are intentional, add them to the allow-list:\n  LibraryTame {rootName} allows <name1> <name2> ..."

/-- Variant without an extern allow-list (most libraries should
    have zero externs anyway). -/
elab "LibraryTame " root:ident : command => do
  let rootName := root.getId
  let env ← getEnv
  match env.find? rootName with
  | none => throwError s!"LibraryTame: root '{rootName}' not found"
  | some _ =>
    let parentNs := rootName.getPrefix
    let inScope : Array Name :=
      if parentNs == .anonymous then #[rootName]
      else #[parentNs]
    let reachable := reachableFromLibrary env rootName
    let mut allViolations : Array LibraryTameViolation := #[]
    for c in reachable do
      if c.toString.startsWith "_private." then continue
      allViolations := allViolations ++ inspectConstant env .empty inScope c
    if allViolations.isEmpty then
      let thmName := Lean.mkIdent (rootName.appendAfter "_library_tame")
      elabCommand (← `(@[manifest_entry] theorem $thmName : True := trivial))
      logInfo m!"LibraryTame {rootName}: ✓ {reachable.size} reachable constants, no violations in {parentNs}.*"
    else
      let lines := allViolations.map LibraryTameViolation.render
      let body := String.intercalate "\n" lines.toList
      throwError s!"LibraryTame {rootName}: {allViolations.size} violations in {parentNs}.*\n{body}\n\nIf any of the externs / axioms are intentional, add them to the allow-list:\n  LibraryTame {rootName} allows <name1> <name2> ..."

/-- Explicit-namespace variant. Use when the entry-point root is
    in a different namespace from the library being audited (e.g.
    a top-level `def auditEntryPoint` that touches `LeanStats.*`):

      LibraryTame LeanStats from auditEntryPoint

    This audits constants under `LeanStats.*` reachable from
    `auditEntryPoint`, ignoring everything outside `LeanStats.*`
    (so stdlib externs don't trip the audit). -/
elab "LibraryTame " ns:ident " from " root:ident : command => do
  let nsName := ns.getId
  let rootName := root.getId
  let env ← getEnv
  match env.find? rootName with
  | none => throwError s!"LibraryTame: root '{rootName}' not found"
  | some _ =>
    let inScope : Array Name := #[nsName]
    let reachable := reachableFromLibrary env rootName
    let mut allViolations : Array LibraryTameViolation := #[]
    for c in reachable do
      if c.toString.startsWith "_private." then continue
      allViolations := allViolations ++ inspectConstant env .empty inScope c
    if allViolations.isEmpty then
      let thmName := Lean.mkIdent (nsName.appendAfter "_library_tame")
      elabCommand (← `(@[manifest_entry] theorem $thmName : True := trivial))
      logInfo m!"LibraryTame {nsName} from {rootName}: ✓ {reachable.size} reachable constants, no violations in {nsName}.*"
    else
      let lines := allViolations.map LibraryTameViolation.render
      let body := String.intercalate "\n" lines.toList
      throwError s!"LibraryTame {nsName} from {rootName}: {allViolations.size} violations in {nsName}.*\n{body}\n\nIf any of the externs / axioms are intentional, add them to the allow-list:\n  LibraryTame {nsName} from {rootName} allows <name1> ..."

/-- Explicit-namespace variant with allow-list. -/
elab "LibraryTame " ns:ident " from " root:ident " allows " allowed:ident* : command => do
  let nsName := ns.getId
  let rootName := root.getId
  let allowedSet : NameSet := allowed.foldl (init := .empty) fun s id => s.insert id.getId
  let env ← getEnv
  match env.find? rootName with
  | none => throwError s!"LibraryTame: root '{rootName}' not found"
  | some _ =>
    let inScope : Array Name := #[nsName]
    let reachable := reachableFromLibrary env rootName
    let mut allViolations : Array LibraryTameViolation := #[]
    for c in reachable do
      if c.toString.startsWith "_private." then continue
      allViolations := allViolations ++ inspectConstant env allowedSet inScope c
    if allViolations.isEmpty then
      let thmName := Lean.mkIdent (nsName.appendAfter "_library_tame")
      elabCommand (← `(@[manifest_entry] theorem $thmName : True := trivial))
      logInfo m!"LibraryTame {nsName} from {rootName}: ✓ {reachable.size} reachable constants, no violations in {nsName}.*"
    else
      let lines := allViolations.map LibraryTameViolation.render
      let body := String.intercalate "\n" lines.toList
      throwError s!"LibraryTame {nsName} from {rootName}: {allViolations.size} violations in {nsName}.*\n{body}"

end DeanLean
