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

end DeanLean.Tests.WorldClaimTests
