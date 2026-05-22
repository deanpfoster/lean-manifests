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

/-- Walk a `Prop` expression looking for vacuous shapes. Reuses
    the same heuristic UnprovenConjecture's `isVacuousProp` uses;
    catches `True`, `∀ ..., True`, etc. -/
private partial def isVacuousProp : Lean.Expr → Bool
  | .const ``True _ => true
  | .forallE _ _ body _ => isVacuousProp body
  | .lam _ _ body _ => isVacuousProp body
  | _ => false

/-- The WorldClaim macro. Produces a `def Name : Prop := T`
    tagged `@[world_claim]`. Checks that the type is non-vacuous
    and that a doc-comment is present.

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
    -- Vacuity check
    let isVacuous ← Lean.Elab.Command.liftTermElabM do
      let tExpr ← Lean.Elab.Term.elabTerm t none
      Lean.Elab.Term.synthesizeSyntheticMVarsNoPostponing
      let tExpr ← Lean.instantiateMVars tExpr
      return isVacuousProp tExpr
    if isVacuous then
      Lean.logWarning m!"WorldClaim {n.getId}: type is vacuous (reduces to `True`). \
        A WorldClaim should state a precise, non-trivial Prop about the runtime \
        environment. If you cannot state the claim as a non-trivial Prop, you do \
        not yet understand what you are assuming; treat that as a research task, \
        not an axiom."
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
