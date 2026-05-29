# Headline-theorem axiom audit

A manifest-driven Lean 4 library promises a small, fixed set of
**headline theorems** to its consumers. The integrity of those
promises rests on the trusted core of Lean — and on whatever extra
`axiom` declarations the project happens to introduce.

`axiom` is invisible at the call site. A theorem stated as

```lean
theorem broadcast_add_transpose : … := by … exact Float.add_comm …
```

does *not* mention `Float.add_comm` in its signature. Downstream
consumers see only the conclusion. If the axiom is unsound (and
`Float.add_comm` is — IEEE 754 is not commutative for NaN
payloads), every dependent theorem inherits the unsoundness
silently.

The remedy has two parts:

1. **Don't use `axiom`** for project-specific assumptions. State
   them as `Prop`-valued definitions or hypothesis parameters so
   they appear in theorem signatures.
2. **Audit headline theorems in CI** so accidental axiom creep
   (yours or a dependency's) fails the build.

This document describes the audit pattern. It pairs with
`MANIFEST_GUIDE.md`, which describes the headline-claims discipline
itself.

---

## 1. The allowed-axiom policy

Headline theorems may depend on **only** Lean's standard trusted
core:

| Axiom               | Why it's universal                              |
|---------------------|-------------------------------------------------|
| `propext`           | Propositional extensionality                    |
| `Classical.choice`  | Underlies `Decidable`, `Classical.byCases`, etc.|
| `Quot.sound`        | Quotient soundness                              |

Any other axiom — including those introduced transitively by
imports — is a regression.

If a project has a *deliberate* extra axiom (e.g. an IEEE 754
arithmetic model that the team has reviewed and signed off on),
extend the allowlist with a comment naming the reviewer and the
PR that approved it. Don't extend it silently.

---

## 2. The audit module

Create `YourProject/AxiomAudit.lean` that imports every module
hosting a headline theorem and emits `#print axioms` for each:

```lean
/-! # YourProject/AxiomAudit.lean — Headline-theorem axiom audit -/

import YourProject.HeadlineModuleA
import YourProject.HeadlineModuleB

namespace YourProject.AxiomAudit

#print axioms YourProject.HeadlineModuleA.theorem_one
#print axioms YourProject.HeadlineModuleA.theorem_two
#print axioms YourProject.HeadlineModuleB.theorem_three

end YourProject.AxiomAudit
```

Add it to your top-level `YourProject.lean` so it builds with the
default target. This way `lake build` on a fresh checkout also
compiles the audit module — proving the headline theorems still
exist under the names the audit expects. (Renames are caught
immediately rather than rotting silently.)

`#print axioms F` prints to stdout one of:

```
'F' depends on axioms: [a1, a2, …]
'F' does not depend on any axioms
```

That output is what the enforcement script parses.

---

## 3. The enforcement script

Create `Scripts/check_axioms.sh`:

```bash
#!/usr/bin/env bash
set -u

ALLOWED_AXIOMS=(propext Classical.choice Quot.sound)
AUDIT_FILE="YourProject/AxiomAudit.lean"

if ! command -v lake >/dev/null 2>&1; then
  echo "check_axioms: 'lake' not on PATH" >&2; exit 2
fi

OUTPUT="$(lake env lean "$AUDIT_FILE" 2>&1)" || {
  echo "check_axioms: AxiomAudit failed to compile" >&2
  echo "$OUTPUT" >&2
  exit 2
}

ALLOWED_RE="$(IFS='|'; echo "${ALLOWED_AXIOMS[*]}")"
FAIL=0

while IFS= read -r line; do
  if [[ "$line" =~ ^\'([^\']+)\'\ depends\ on\ axioms:\ \[(.*)\]$ ]]; then
    THM="${BASH_REMATCH[1]}"
    IFS=',' read -ra AX <<< "${BASH_REMATCH[2]}"
    for a in "${AX[@]}"; do
      a="${a## }"; a="${a%% }"
      [[ -z "$a" ]] && continue
      if ! [[ "$a" =~ ^($ALLOWED_RE)$ ]]; then
        echo "FORBIDDEN AXIOM: $THM depends on $a" >&2
        FAIL=1
      fi
    done
  fi
done <<< "$OUTPUT"

[[ $FAIL -eq 1 ]] && exit 1
echo "check_axioms: all headline theorems are axiom-clean."
```

`chmod +x` it. It exits:

- `0` — clean.
- `1` — forbidden axiom found (regression).
- `2` — infrastructure failure (no lake, audit didn't compile, etc.).

`lake env lean <file>` is the right invocation: it elaborates the
file in the project's environment and prints command output (like
`#print axioms`) to stdout. Plain `lake build` does not surface
this output.

---

## 4. Wiring into the lakefile

A TOML `lakefile.toml` does not (yet) have a first-class
`[[script]]` for shell commands. The supported pattern is:

1. Make `AxiomAudit.lean` a regular module of the default-target
   library, so it builds with `lake build`.
2. Run `Scripts/check_axioms.sh` from CI as a separate step.

Add a comment block at the top of `lakefile.toml` documenting
both the module and the script so future maintainers find the
audit immediately:

```toml
# Headline-theorem axiom audit.
#
# `YourProject.AxiomAudit` is a regular module of the
# `YourProject` library; building the default target compiles
# it and emits `#print axioms` lines for every headline theorem.
# To enforce the audit (fail on any forbidden axiom), run:
#
#     ./Scripts/check_axioms.sh
#
# Wired into CI via .github/workflows/<your-workflow>.yml.
# See ~/lean-manifests/templates/MANIFEST_AXIOM_AUDIT.md.
```

If you use `lakefile.lean` instead of TOML, you can express the
same thing as a `script`:

```lean
package «yourproject» where
  -- …

@[default_target]
lean_lib «YourProject»

script axiomAudit do
  let out ← IO.Process.output {
    cmd := "./Scripts/check_axioms.sh", args := #[]
  }
  IO.print out.stdout
  IO.eprint out.stderr
  return out.exitCode
```

Then `lake script run axiomAudit` is a first-class invocation.

---

## 5. Wiring into CI

Add the audit step **after** the build step, since the audit
relies on a successful elaboration:

```yaml
# .github/workflows/lean_action_ci.yml
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: leanprover/lean-action@v1
      - name: Axiom audit
        run: ./Scripts/check_axioms.sh
```

The audit is fast (sub-second after a warm build) and worth
running on every PR.

---

## 6. What to do when the audit fires

A forbidden-axiom failure is one of three things, in order of
likelihood:

1. **You added an `axiom`.** Convert it to a hypothesis or a
   `Prop`-valued definition, and pass it to the theorems that
   need it. Keep the axiom out of the trusted core.

2. **A dependency added an `axiom`.** Investigate. If the
   dependency is trusted and the axiom is justified, document the
   addition in `docs/axiom-policy.md` and (only then) extend
   `ALLOWED_AXIOMS`. If not, switch dependencies or vendor the
   needed pieces.

3. **You renamed a headline theorem.** `AxiomAudit.lean` failed to
   compile. Update the audit list and the manifest in lockstep —
   if a headline theorem disappears, your manifest's promises
   change and consumers need to know.

---

## 7. Anti-patterns

**Don't** mark a sorry-bearing theorem as `axiom` to "make CI
green." That trades a yellow flag for a hidden silent failure.
Use a `Prop`-valued definition (`def foo_conjecture : Prop := …`)
instead — it documents the conjecture without smuggling it into
the trusted core.

**Don't** extend `ALLOWED_AXIOMS` to silence a regression. The
allowlist is a policy decision, not a workaround.

**Don't** audit *every* theorem. The audit is for headline
promises. Internal lemmas can use whatever proof techniques the
team likes, as long as the headline theorems they support stay
clean. The audit list is a manifest in miniature.
