import Lean
import DeanLean.Attr

/-! # DeanLean.WorldClaim — opaque assumptions about the runtime world

A `WorldClaim` is a `Prop` definition that names an environmental
fact Lean cannot prove — something about the OS, hardware, network,
or external semantics. Theorems that depend on the fact take a
proof of the `WorldClaim` Prop as an explicit hypothesis; nobody
ever produces such a proof, but the user's reality "supplies" it
when they run on a system where the claim holds.

## Why this isn't a ManifestAxiom

`ManifestAxiom` declares an unconditional `theorem ... := sorry`,
which means downstream theorems that use the axiom INHERIT a sorry
in their proof terms (visible to `print axioms`). The audit-grep
discipline lists ManifestAxioms separately, but in the kernel-level
trust report they look like any other unproven thing.

`WorldClaim` instead declares `def Foo : Prop := T`. There is no
sorry. There is no axiom. The `def` is just a name for a `Prop`.
Theorems that need the fact write `(h : Foo) → ...` in their type;
the proof term references `h`, not a sorry-using axiom. Result:
the kernel sees only `Classical.choice`, `propext`, `Quot.sound`
in the axiom set — no project-specific axioms.

## Usage

```lean
/-- Linux's realpath returns a path inside the workspace root.
    Falsifying observation: a directory layout where the path
    returned by realpath contains ".." after resolution. -/
WorldClaim RealpathHonest (root : FilePath) : Prop :=
  ∀ p, confine root (realpath p) ⊆ root

theorem confine_safe
    (root : FilePath) (h_realpath : RealpathHonest root) (p : FilePath) :
    ... := by
  ...
  exact h_realpath p ⟨...⟩  -- use h_realpath as a hypothesis
```

## Discipline checks

The macro checks:

1. **Doc-comment is required.** A WorldClaim without one is an
   unaudited assumption hiding in plain sight; the doc-comment
   should describe what would falsify the claim (the adversarial
   observation that would break it).

2. **Type cannot be vacuous.** `True` and tautology-shaped types
   are rejected. If you cannot state the claim precisely as a
   non-trivial Prop, you don't yet understand what you're
   assuming; that's a research task, not an axiom.

3. **`@[world_claim]` tag.** The resulting `def` is tagged so
   tooling (trust reports, `FullyAttested`, etc.) can enumerate
   every world claim in the codebase. Adding a new one is visible
   in the trust-baseline diff.

## Trust posture

`WorldClaim` produces a `def`, not a `theorem`. The `def` has no
proof obligation. It has no axiom. The kernel doesn't see it as
anything but a name for a Prop.

Theorems that USE a WorldClaim take it as a hypothesis. Their
type explicitly mentions the WorldClaim Prop. Their proof terms
reference the hypothesis by name. There is no hidden dependency.

If a theorem with a WorldClaim hypothesis is invoked, the caller
must supply a proof of the WorldClaim. Nobody can. Therefore the
theorem is never directly applied in pure-Lean code; it is
applied at the boundary where l3m talks to the user, where the
user's reality "supplies" the proof by being a real Linux system.

This is the same discipline as classical mathematics' "modulo
Riemann" theorems: nobody supplies a proof of Riemann, but you
can still write theorems that follow from it, and you can still
verify their proofs are correct conditional on Riemann.
-/

set_option autoImplicit false

namespace DeanLean

open Lean

/-- The `@[world_claim]` tag attribute. Marks `def : Prop`
    declarations that name environmental assumptions Lean cannot
    prove. Tooling (trust reports, FullyAttested, etc.) reads
    this set to enumerate world claims. -/
initialize worldClaimAttr : TagAttribute ←
  registerTagAttribute `world_claim
    "marks a Prop definition as an environmental world claim"

/-- True iff `n` is tagged with `@[world_claim]`. -/
def hasWorldClaimAttr (env : Environment) (n : Name) : Bool :=
  worldClaimAttr.hasTag env n

/-- Names of all `@[world_claim]`-tagged declarations. -/
def worldClaimNames (env : Environment) : Array Name :=
  worldClaimAttr.ext.getState env |>.toArray

/-- The `@[falsifies "<tier>"]` parametric attribute. Tags a
    WorldClaim with how it would be falsified:

      "lean-testable" — provable or testable inside Lean's runtime
        (a smoke script can verify it); promotable to TestedConjecture
      "shell-testable" — needs xxd, strace, or a sibling-process
        observer; not testable from inside Lean alone
      "OS-axiomatic" — about a foreign system (Linux kernel, git,
        hardware, terminal), behavior may change with version

    Per Rule 10 of `docs/spec-driven-manifests.md`. Trust reports
    can group WorldClaims by tier; consumers know which can be
    promoted to TestedConjectures vs which are permanent.

    Usage:

      @[falsifies "OS-axiomatic"]
      WorldClaim realpathHonest := ...

    The string is enforced at the macro level: only the three
    documented tiers are accepted. -/
syntax (name := falsifiesAttr) "falsifies " str : attr

initialize falsifiesExtension : ParametricAttribute String ←
  registerParametricAttribute {
    name := `falsifiesAttr
    descr := "tier label for a WorldClaim's falsifiability — \"lean-testable\", \"shell-testable\", or \"OS-axiomatic\""
    getParam := fun _name stx => match stx with
      | `(attr| falsifies $s:str) =>
        let tier := s.getString
        if tier == "lean-testable" || tier == "shell-testable" || tier == "OS-axiomatic" then
          return tier
        else
          throwError m!"falsifies: tier must be one of \"lean-testable\", \"shell-testable\", \"OS-axiomatic\" — got {tier}"
      | _ => throwError "invalid falsifies attribute"
  }

/-- Get the `@[falsifies]` tier of a WorldClaim, if any. -/
def getFalsifiesTier? (env : Environment) (n : Name) : Option String :=
  falsifiesExtension.getParam? env n

/-- Walk a `Prop` expression looking for vacuous shapes. Reuses
    the same heuristic UnprovenConjecture's `isVacuousProp` uses;
    catches `True`, `∀ ..., True`, etc. -/
private partial def isVacuousProp : Lean.Expr → Bool
  | .const ``True _ => true
  | .forallE _ _ body _ => isVacuousProp body
  | .lam _ _ body _ => isVacuousProp body
  | _ => false

/-- Walk reachable constants from an Expr's used-constants set.
    Used for the "does the WorldClaim's type touch something Lean
    can't model" structural check. -/
private partial def reachableFromExpr (env : Lean.Environment) (e : Lean.Expr) : Lean.NameSet :=
  let initial : Lean.NameSet := e.getUsedConstants.foldl (init := .empty) (·.insert ·)
  initial.fold expand initial
where
  expand (visited : Lean.NameSet) (n : Lean.Name) : Lean.NameSet :=
    if visited.contains n then visited
    else
      let visited := visited.insert n
      match env.find? n with
      | none => visited
      | some info => info.getUsedConstantsAsSet.fold expand visited

/-- True iff a WorldClaim's type structurally touches something
    Lean cannot model in pure logic — IO, IO.Ref, @[extern], or
    a constant from an OS-flavored namespace (System.*, Lean's
    own IO primitives). A WorldClaim whose type is fully pure-Lean
    should probably be an UnprovenConjecture instead, since the
    "world" part isn't visible in the type. -/
private def typeReachesForeignSystem (env : Lean.Environment) (e : Lean.Expr) : Bool :=
  let reachable := reachableFromExpr env e
  reachable.any fun n =>
    -- @[extern]-tagged constants
    (Lean.getExternAttrData? env n).isSome ||
    -- IO/IO.Ref/EIO: Lean's IO monad
    n == ``IO || n == ``BaseIO || n == ``EIO ||
    -- System.* — paths, processes, env
    (n.toString.startsWith "System." ) ||
    -- Constants from L3m.Defs.Audit* (event-typed runtime claims) —
    -- specific to l3m's pattern but a reasonable heuristic for any
    -- project that names runtime-event types in WorldClaim signatures.
    (n.toString.endsWith ".FsEvent") ||
    (n.toString.endsWith ".WriteEvent") ||
    (n.toString.endsWith ".NetworkRequest") ||
    (n.toString.endsWith ".EnvRead") ||
    (n.toString.endsWith ".SubprocessInvocation") ||
    (n.toString.endsWith ".ChannelDestination") ||
    (n.toString.endsWith ".GitAction") ||
    (n.toString.endsWith ".SafePath")

/-- The WorldClaim macro. Produces a `def Name : Prop := T`
    tagged `@[world_claim]`. Checks that the type is non-vacuous,
    that a doc-comment is present, and that the type structurally
    references something outside pure Lean (so it's actually a
    "world" claim and not a hidden UnprovenConjecture).

    Form:

      /-- Falsifying observation: ... -/
      WorldClaim Name := ∀ args, T

    Parameters that the claim depends on (e.g. `root : FilePath`)
    go inside the `∀` in the body, not as macro arguments.
-/
syntax (name := worldClaimSyn) (docComment)? "WorldClaim " ident " := " term : command

open Lean Elab Command in
@[command_elab worldClaimSyn]
def elabWorldClaim : CommandElab := fun stx => do
  match stx with
  | `($[$doc?:docComment]? WorldClaim $n:ident := $t:term) =>
    -- Doc-comment requirement
    if doc?.isNone then
      Lean.logWarning m!"WorldClaim {n.getId}: missing doc-comment. \
        Conventionally a WorldClaim's doc-comment describes the FALSIFYING \
        observation that would invalidate the claim — the adversarial scenario \
        that would break it. This is the audit surface; without it the claim \
        is undocumented."
    -- Vacuity + foreign-system check
    let (isVacuous, isForeign) ← Lean.Elab.Command.liftTermElabM do
      let tExpr ← Lean.Elab.Term.elabTerm t none
      Lean.Elab.Term.synthesizeSyntheticMVarsNoPostponing
      let tExpr ← Lean.instantiateMVars tExpr
      let env ← Lean.getEnv
      return (isVacuousProp tExpr, typeReachesForeignSystem env tExpr)
    if isVacuous then
      Lean.logWarning m!"WorldClaim {n.getId}: type is vacuous (reduces to `True`). \
        A WorldClaim should state a precise, non-trivial Prop about the runtime \
        environment. If you cannot state the claim as a non-trivial Prop, you do \
        not yet understand what you are assuming; treat that as a research task, \
        not an axiom."
    if !isVacuous && !isForeign then
      Lean.logWarning m!"WorldClaim {n.getId}: type does not structurally reach \
        any foreign-system constant (no @[extern], IO, System.*, or audit-event \
        type in its dependency tree). A WorldClaim should be about something \
        Lean cannot model in pure logic. If your claim is purely about Lean \
        values, it's probably an UnprovenConjecture (a TODO to be proven later) \
        rather than a WorldClaim (a permanent assumption about the world). \
        Consider switching to UnprovenConjecture, or expand the type to mention \
        the foreign system you actually depend on."
    -- Emit: def Name : Prop := T, tagged @[world_claim].
    elabCommand (← `(@[world_claim] def $n : Prop := $t))
    -- Attach the doc-comment to the resulting def.
    if let some docCmt := doc? then
      let docStr ← Lean.getDocStringText docCmt
      let ns ← getCurrNamespace
      let fullName := ns ++ n.getId
      Lean.addDocString fullName docStr
  | _ => throwUnsupportedSyntax

end DeanLean
