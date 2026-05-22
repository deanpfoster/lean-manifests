import DeanLean.WorldClaim

namespace DeanLean.Tests.WorldClaimTests

/-- Linux's realpath is honest about path containment.
    Falsifying observation: a directory layout where realpath
    returns a path containing ".." after symlink resolution. -/
@[falsifies "OS-axiomatic"]
WorldClaim RealpathHonest := ∀ (root p : System.FilePath),
  -- Toy claim: realpath result has a non-trivial property
  -- (concrete claim would reference a real `realpath` extern).
  p.toString.length ≥ 0

-- Verify the def exists and is tagged
#check @RealpathHonest
example : RealpathHonest = ∀ (root p : System.FilePath), p.toString.length ≥ 0 := rfl

-- Verify we can use it as a hypothesis
theorem usesRealpathHonest (h : RealpathHonest) :
    ∀ p : System.FilePath, p.toString.length ≥ 0 := by
  intro p
  exact h "/tmp" p

-- The @[falsifies] attribute is verified by the compile: an
-- invalid tier string would have errored at the WorldClaim above.
-- Tooling reads the tier via getFalsifiesTier? at the consumer's
-- environment.

-- ── Regression test: WorldClaim accepts an attribute group ──
-- The grammar is: (docComment)? (attributes)? "WorldClaim" ident ":=" term.
-- Ensures `@[falsifies "..."]` (or any other attribute) works.

/-- The OS clock advances. Falsifying observation: a deliberately
    rigged BIOS that returns the same epoch for every IO call. -/
@[falsifies "OS-axiomatic"]
WorldClaim ClockAdvances := ∀ (s : String),
  s.length ≥ 0 ∧ String.length s = s.length

#check @ClockAdvances

-- Multiple user attributes also work:
/-- A claim with two attributes. Falsifying observation: any
    breakage of the underlying environmental assumption. -/
@[falsifies "shell-testable", inline]
WorldClaim TwoAttrs := ∀ (s : String), s.length = s.length

#check @TwoAttrs

end DeanLean.Tests.WorldClaimTests
