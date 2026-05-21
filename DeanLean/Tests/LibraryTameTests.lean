import DeanLean.LibraryTame

/-! # Tests/LibraryTameTests — smoke that LibraryTame catches the
right things and emits the right artifact.

Three small tame entry points (no init, no unsafe, no externs)
should pass cleanly and emit `<root>_library_tame : True` artifacts.
The build will fail if `LibraryTame` flags any of them as having
violations.
-/

namespace DeanLean.Tests.LibraryTameTests

/-- A trivial tame function: pure data. -/
def pureLeaf (n : Nat) : Nat := n + 1

/-- A trivial tame helper that calls pureLeaf. -/
def pureBranch (n : Nat) : Nat := pureLeaf n * 2

/-- A small tame root that uses both helpers. -/
def smokeRoot (n : Nat) : Nat := pureBranch n + pureLeaf n

end DeanLean.Tests.LibraryTameTests

LibraryTame DeanLean.Tests.LibraryTameTests.smokeRoot

/-! ## Negative cases

These are intentionally not checked by `LibraryTame` invocations
in this file (the build would fail). They document the violations
the audit catches. To exercise the negative path manually:

  -- This would fail: 'unsafe def: badRoot'
  unsafe def badRoot (n : Nat) : Nat := n
  LibraryTame badRoot
-/
namespace DeanLean.Tests.LibraryTameTests.NegativeCases

/-- An unsafe def — would be flagged by LibraryTame. Not audited
    here so the build doesn't break. -/
unsafe def unsafeExample (n : Nat) : Nat := n

end DeanLean.Tests.LibraryTameTests.NegativeCases
