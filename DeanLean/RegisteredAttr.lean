import Lean

/-! # DeanLean.RegisteredAttr — generic typed-value tag-attribute helper

A common pattern in Lean projects is "mark a top-level definition
of type `α` with a tag attribute, then collect all marked values
into a registry at runtime". l3m uses this for `@[tame_tool]`
collecting `RegisteredTool` values; mathlib uses similar patterns
for `@[simp]`, `@[ext]`, `@[norm_cast]`, etc.

The mechanical part is fiddly: register a `TagAttribute`, define
helpers to query the tagged set, use `Environment.evalConst`
(unsafe) to extract typed values, wrap with `@[implemented_by]`
to expose a safe surface. Each project re-invents this boilerplate.

`RegisteredAttr α` packages the pattern into a single helper.
Users get:

  - `RegisteredAttr.register name descr : IO (RegisteredAttr α)`
  - `r.has? env n  : Bool`
  - `r.names env   : Array Name`
  - `r.value? env n : Option α`     (safe wrapper over evalConst)
  - `r.collect env  : Array α`      (every tagged value, evaluated)

## Usage

```lean
import DeanLean.RegisteredAttr
import MyProject.MyType

initialize myAttr : RegisteredAttr MyType ←
  RegisteredAttr.register `my_thing "marks a MyType for the registry"

-- Then consumers do:
-- @[my_thing] def someValue : MyType := ...

def collectMyThings (env : Environment) : Array MyType :=
  myAttr.collect env
```

## Trust posture

The `value?` extractor uses `Environment.evalConst`, which is
`unsafe` — it executes compiled code from the build artifacts to
materialize a value. If a malicious macro or extern produced
arbitrary code under the marked name, evalConst would run it.

This is the standard Lean attribute-extension trust model:
attributes are part of the elaboration trusted base. Don't tag
declarations whose body comes from untrusted sources.

## Why a structure not a typeclass

A typeclass would let `MyType` be inferred from context, but
`initialize myAttr : RegisteredAttr MyType` already pins the type
explicitly, and concrete-typed values are easier to pass through
the IO + Environment boundary. The structure is one level less
clever and one level more obvious.
-/

set_option autoImplicit false

namespace DeanLean

open Lean

/-- A registered tag-attribute that collects values of type `α`.
    Construct via `RegisteredAttr.register` (must run in `IO` /
    `initialize` because attribute registration is stateful). -/
structure RegisteredAttr (α : Type) where
  /-- The underlying TagAttribute. Exposed for callers who want
      direct access to its primitives; most users use the `has?`,
      `names`, `value?`, `collect` methods below. -/
  attr : TagAttribute
  /-- The attribute's name (e.g. ``my_thing``). Same as
      `attr.attr.name`; cached here for readability. -/
  attrName : Name
  deriving Inhabited

namespace RegisteredAttr

variable {α : Type}

/-- Register a new tag attribute and wrap it as a `RegisteredAttr α`.
    Use inside `initialize` so registration happens at module-init
    time. -/
def register (name : Name) (descr : String) : IO (RegisteredAttr α) := do
  let attr ← registerTagAttribute name descr
  return { attr, attrName := name }

/-- True iff `n` is tagged with this attribute. -/
def has? (r : RegisteredAttr α) (env : Environment) (n : Name) : Bool :=
  r.attr.hasTag env n

/-- Names of all declarations tagged with this attribute. -/
def names (r : RegisteredAttr α) (env : Environment) : Array Name :=
  r.attr.ext.getState env |>.toArray

/-- Extract the value of a tagged declaration. Returns `none` if
    the declaration isn't tagged, doesn't exist, or fails to
    evaluate as `α`.

    Implementation uses `unsafe` `Environment.evalConst`, hidden
    behind `@[implemented_by]`. -/
unsafe def value?Unsafe (r : RegisteredAttr α) (env : Environment) (n : Name) :
    Option α :=
  if !r.has? env n then none
  else match env.evalConst α {} n with
    | .ok v => .some v
    | .error _ => none

@[implemented_by value?Unsafe]
opaque value? (r : RegisteredAttr α) (env : Environment) (n : Name) :
    Option α

/-- Evaluate every tagged declaration to its `α` value. Tags whose
    declarations fail to evaluate are silently skipped (so a
    half-migrated codebase still builds; consumers can audit
    by comparing `names env` to `collect env |>.size`). -/
def collect (r : RegisteredAttr α) (env : Environment) : Array α :=
  r.names env |>.filterMap (r.value? env)

end RegisteredAttr

end DeanLean
