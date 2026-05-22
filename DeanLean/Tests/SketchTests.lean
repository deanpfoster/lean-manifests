import DeanLean.Basic

namespace DeanLean.Tests.SketchTests

/-- Stand-in for a future conjecture about `foo`. When the
    underlying machinery exists to phrase the precise Prop
    (today: we don't yet have a notion of "reachable IO
    operations from `foo`'s body"), promote this `Sketch` to
    an `UnprovenConjecture` whose body is the Prop, and move
    this prose into that conjecture's doc-comment. -/
Sketch foo_io_surface_bounded

/-- A Sketch about a function whose signature exists but
    whose contract isn't yet expressible. -/
Sketch bar_terminates_on_well_formed_input

-- Verify Sketches produce defs of type Unit
example : foo_io_surface_bounded = () := rfl
example : bar_terminates_on_well_formed_input = () := rfl

-- Verify the @[sketch] tag is queryable
#check @hasSketchAttr

end DeanLean.Tests.SketchTests
