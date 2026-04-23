# Cslib.Computability.URM.StandardForm

## Summary
Defines standard-form programs (all jump targets bounded by program length) and the `toStandardForm` transformation that caps jumps. Proves a bisimulation between original and standard-form programs, yielding halting equivalence and eval preservation.

## Vocabulary
| Name | Kind | Description |
|------|------|-------------|
| `Program.IsStandardForm` | def | All jump targets bounded by program length |
| `Program.toStandardForm` | def | Cap all jump targets at program length |

## Theorems

| # | Name | Signature | Visibility |
|---|------|-----------|------------|
| 1 | `toStandardForm_length` | `(p : Program) : p.toStandardForm.length = p.length` | PUBLIC |
| 2 | `toStandardForm_isStandardForm` | `(p : Program) : p.toStandardForm.IsStandardForm` | PUBLIC |
| 3 | `getElem?_toStandardForm` | `(p : Program) (i : ℕ) : p.toStandardForm[i]? = (p[i]?).map (Instr.capJump p.length)` | PUBLIC |
| 4 | `toStandardForm_idempotent` | `(p : Program) : p.toStandardForm.toStandardForm = p.toStandardForm` | PUBLIC |
| 5 | `straight_line_IsStandardForm` | `{p : Program} (hsl : p.IsStraightLine) : p.IsStandardForm` | PUBLIC |
| 6 | `Step.toStandardForm` | `{p : Program} {s s' : State} (hstep : Step p s s') : Step p.toStandardForm s s' ∨ (s'.isHalted p ∧ ∃ s₂, Step p.toStandardForm s s₂ ∧ s₂.isHalted p.toStandardForm ∧ s'.regs = s₂.regs)` | PUBLIC |
| 7 | `Steps.toStandardForm_halts` | `{p : Program} {s s' : State} (hsteps : Steps p s s') (hhalted : s'.isHalted p) : ∃ s₂, Steps p.toStandardForm s s₂ ∧ s₂.isHalted p.toStandardForm ∧ s'.regs = s₂.regs` | PUBLIC |
| 8 | `Halts.toStandardForm` | `{p : Program} {inputs : List ℕ} (h : Halts p inputs) : Halts p.toStandardForm inputs` | PUBLIC |
| 9 | `Step.from_toStandardForm` | `{p : Program} {s s' : State} (hstep : Step p.toStandardForm s s') : Step p s s' ∨ (s'.isHalted p.toStandardForm ∧ ∃ s₂, Step p s s₂ ∧ s₂.isHalted p ∧ s'.regs = s₂.regs)` | PUBLIC |
| 10 | `Steps.from_toStandardForm_halts` | `{p : Program} {s s' : State} (hsteps : Steps p.toStandardForm s s') (hhalted : s'.isHalted p.toStandardForm) : ∃ s₂, Steps p s s₂ ∧ s₂.isHalted p ∧ s'.regs = s₂.regs` | PUBLIC |
| 11 | `Halts.of_toStandardForm` | `{p : Program} {inputs : List ℕ} (h : Halts p.toStandardForm inputs) : Halts p inputs` | PUBLIC |
| 12 | `Halts.toStandardForm_iff` | `{p : Program} {inputs : List ℕ} : Halts p inputs ↔ Halts p.toStandardForm inputs` | PUBLIC |
| 13 | `evalState_toStandardForm_regs` | `(hp : (evalState p inputs).Dom) (hq : (evalState p.toStandardForm inputs).Dom) : ((evalState p inputs).get hp).regs = ((evalState p.toStandardForm inputs).get hq).regs` | PUBLIC |
| 14 | `eval_toStandardForm` | `{p : Program} {inputs : List ℕ} : eval p inputs = eval p.toStandardForm inputs` | PUBLIC |
| 15 | `toStandardForm_equiv` | `(p : Program) : p.toStandardForm ≈ p` | PUBLIC |

## Statistics
- Theorems/Lemmas: 15
- Definitions: 2
- Lines of code: 230
- Imports: Cslib.Computability.URM.StraightLine
