# Cslib.Computability.URM.Defs

## Summary
Core definitions for Unlimited Register Machines (URMs): the four instruction types (Z, S, T, J), register state as `ℕ → ℕ`, programs as lists of instructions, and machine state (program counter + registers).

## Vocabulary
| Name | Kind | Description |
|------|------|-------------|
| `Instr` | inductive | URM instructions: Z (zero), S (successor), T (transfer), J (conditional jump) |
| `Instr.readsFrom` | def | Registers read by an instruction |
| `Instr.writesTo` | def | Register written by an instruction (if any) |
| `Instr.maxRegister` | def | Maximum register index referenced |
| `Instr.shiftJumps` | def | Shift jump targets by offset |
| `Instr.shiftRegisters` | def | Shift register references by offset |
| `Regs` | abbrev | Register contents: `ℕ → ℕ` |
| `Regs.zero` | def | All-zero registers |
| `Regs.read` | def | Read register n |
| `Regs.write` | def | Write value to register n |
| `Regs.ofInputs` | def | Initialize registers from input list |
| `Regs.output` | def | Extract output from register 0 |
| `Program` | abbrev | `List Instr` |
| `Program.maxRegister` | def | Max register index in program |
| `Program.shiftJumps` | def | Shift all jump targets in program |
| `Program.shiftRegisters` | def | Shift all register references in program |
| `State` | structure | Machine state: program counter + registers |
| `State.init` | def | Initial state from input list |
| `State.isHalted` | def | Whether PC is past program end |

## Statistics
- Theorems/Lemmas: 0
- Definitions/Structures: 19
- Lines of code: 190
- Imports: Cslib.Init, Mathlib.Data.Finset.Insert
