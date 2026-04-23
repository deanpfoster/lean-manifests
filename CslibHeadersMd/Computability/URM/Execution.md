# Cslib.Computability.URM.Execution

## Summary
Defines single-step and multi-step execution semantics for URMs, including halting, divergence, and halting-with-result. Proves determinism, confluence, and the connection between halting and partial evaluation. Provides scoped notation `p ↓ inputs`, `p ↑ inputs`, `p ↓ inputs ≫ result`.

## Vocabulary
| Name | Kind | Description |
|------|------|-------------|
| `Step` | inductive | Single-step execution relation (5 constructors: zero, succ, transfer, jump_eq, jump_ne) |
| `Steps` | abbrev | Multi-step execution: `ReflTransGen (Step p)` |
| `Halts` | def | Program halts on inputs |
| `Diverges` | def | Program diverges on inputs |
| `HaltsWithResult` | def | Program halts on inputs with specific result in R[0] |
| `evalState` | def | Partial evaluation returning full halting state |
| `eval` | def | Partial evaluation returning R[0] value |
| `ProgramEquiv` | def | Two programs produce same result for all inputs |

## Theorems

| # | Name | Signature | Visibility |
|---|------|-----------|------------|
| 1 | `Step.deterministic` | `Relator.RightUnique (Step p)` | PUBLIC |
| 2 | `Step.no_step_of_halted` | `{s s' : State} (hhalted : s.isHalted p) : ¬Step p s s'` | PUBLIC |
| 3 | `Step.preserves_register` | `{s s' : State} {r : ℕ} (hstep : Step p s s') (hr : ∀ instr, p[s.pc]? = some instr → instr.writesTo ≠ some r) : s'.regs.read r = s.regs.read r` | PUBLIC |
| 4 | `isHalted_iff_normal` | `{p : Program} {s : State} : s.isHalted p ↔ Relation.Normal (Step p) s` | PUBLIC |
| 5 | `step_confluent` | `(p : Program) : Relation.Confluent (Step p)` | PUBLIC |
| 6 | `Steps.preserves_register` | `{s s' : State} {r : ℕ} (hsteps : Steps p s s') (hr : ∀ instr, instr ∈ p → instr.writesTo ≠ some r) : s'.regs.read r = s.regs.read r` | PUBLIC |
| 7 | `Steps.eq_of_halts` | `{init s₁ s₂ : State} (h1 : Steps p init s₁) (hh1 : s₁.isHalted p) (h2 : Steps p init s₂) (hh2 : s₂.isHalted p) : s₁ = s₂` | PUBLIC |
| 8 | `halts_iff_normalizable` | `{p : Program} {inputs : List ℕ} : Halts p inputs ↔ Relation.Normalizable (Step p) (State.init inputs)` | PUBLIC |
| 9 | `evalState_spec` | `{inputs : List ℕ} (h : (evalState p inputs).Dom) : let s := (evalState p inputs).get h; Steps p (State.init inputs) s ∧ s.isHalted p` | PUBLIC |
| 10 | `HaltsWithResult.toHalts` | `(h : p ↓ inputs ≫ result) : p ↓ inputs` | PUBLIC |
| 11 | `Halts.toHaltsWithResult` | `(h : p ↓ inputs) : p ↓ inputs ≫ ((evalState p inputs).get h).regs.output` | PUBLIC |
| 12 | `haltsWithResult_iff_eval` | `p ↓ inputs ≫ result ↔ eval p inputs = Part.some result` | PUBLIC |
| 13 | `ProgramEquiv.equivalence` | `Equivalence ProgramEquiv` | PUBLIC |

## Notation (scoped)
- `p ↓ inputs` -- halting
- `p ↑ inputs` -- divergence
- `p ↓ inputs ≫ result` -- halting with result

## Statistics
- Theorems/Lemmas: 13
- Definitions: 6
- Instances: 1 (Setoid Program)
- Lines of code: 266
- Imports: Cslib.Computability.URM.Defs, Cslib.Foundations.Data.Relation, Mathlib.Data.Part
