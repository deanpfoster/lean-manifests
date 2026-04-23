# Cslib.Computability.URM.StraightLine

## Summary
Defines straight-line programs (those without jumps) and proves they always halt, reaching PC equal to program length. Provides characterization of intermediate states and final registers.

## Vocabulary
| Name | Kind | Description |
|------|------|-------------|
| `Program.IsStraightLine` | def | Program contains no jump instructions |
| `straightLine_finalState` | def | The halting state for a straight-line program |
| `straightLine_finalRegs` | def | Final registers after running a straight-line program |

## Theorems

| # | Name | Signature | Visibility |
|---|------|-----------|------------|
| 1 | `Program.IsStraightLine.append` | `(hp : p.IsStraightLine) (hq : q.IsStraightLine) : (p ++ q).IsStraightLine` | PUBLIC |
| 2 | `Program.IsStraightLine.cons` | `(hinstr : ¬instr.IsJump) (hp : p.IsStraightLine) : (instr :: p).IsStraightLine` | PUBLIC |
| 3 | `Program.IsStraightLine.singleton` | `(h : ¬instr.IsJump) : Program.IsStraightLine [instr]` | PUBLIC |
| 4 | `Step.of_nonJump` | `{p : Program} {s : State} (hlt : s.pc < p.length) (hnonjump : ¬(p[s.pc]'hlt).IsJump) : ∃ s', Step p s s' ∧ s'.pc = s.pc + 1` | PUBLIC |
| 5 | `straight_line_halts_from_regs` | `{p : Program} (hsl : p.IsStraightLine) (r : Regs) : ∃ s, Steps p ⟨0, r⟩ s ∧ s.isHalted p ∧ s.pc = p.length` | PUBLIC |
| 6 | `straight_line_halts` | `{p : Program} (hsl : p.IsStraightLine) (inputs : List ℕ) : Halts p inputs` | PUBLIC |
| 7 | `straightLine_finalState_spec` | `(hsl : p.IsStraightLine) (r : Regs) : let s := straightLine_finalState hsl r; Steps p ⟨0, r⟩ s ∧ s.isHalted p ∧ s.pc = p.length` | PUBLIC |
| 8 | `straightLine_finalRegs_eq_of_halted` | `(hsl : p.IsStraightLine) (r : Regs) (s : State) (hsteps : Steps p ⟨0, r⟩ s) (hhalted : s.isHalted p) : s.regs = straightLine_finalRegs hsl r` | PUBLIC |
| 9 | `straight_line_state_at_pc` | `(hsl : p.IsStraightLine) (r : Regs) (targetPc : ℕ) (htarget : targetPc ≤ p.length) : ∃ s, Steps p ⟨0, r⟩ s ∧ s.pc = targetPc` | PUBLIC |

## Statistics
- Theorems/Lemmas: 9
- Definitions: 3
- Lines of code: 137
- Imports: Cslib.Computability.URM.Basic, Cslib.Computability.URM.Execution
