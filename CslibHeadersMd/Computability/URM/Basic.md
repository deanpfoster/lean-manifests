# Cslib.Computability.URM.Basic

## Summary
Basic lemmas for URM types: register read/write properties, state extensionality, instruction jump predicates (IsJump), bounded jump targets (JumpsBoundedBy), and jump capping (capJump).

## Vocabulary
| Name | Kind | Description |
|------|------|-------------|
| `Instr.IsJump` | def | Predicate: instruction is a J instruction |
| `Instr.JumpsBoundedBy` | def | Predicate: jump target is bounded by a length |
| `Instr.capJump` | def | Cap jump target to at most a given length |

## Theorems

| # | Name | Signature | Visibility |
|---|------|-----------|------------|
| 1 | `Regs.write_read_self` | `(σ : Regs) (n v : ℕ) : (σ.write n v).read n = v` | PUBLIC |
| 2 | `Regs.write_read_of_ne` | `(σ : Regs) (m n v : ℕ) (h : m ≠ n) : (σ.write n v).read m = σ.read m` | PUBLIC |
| 3 | `State.isHalted_iff` | `(s : State) (p : Program) : s.isHalted p ↔ p.length ≤ s.pc` | PUBLIC |
| 4 | `State.ext` | `{s₁ s₂ : State} (hpc : s₁.pc = s₂.pc) (hregs : s₁.regs = s₂.regs) : s₁ = s₂` | PUBLIC |
| 5 | `Instr.Z_nonJump` | `(n : ℕ) : ¬(Z n).IsJump` | PUBLIC |
| 6 | `Instr.S_nonJump` | `(n : ℕ) : ¬(S n).IsJump` | PUBLIC |
| 7 | `Instr.T_nonJump` | `(m n : ℕ) : ¬(T m n).IsJump` | PUBLIC |
| 8 | `Instr.J_IsJump` | `(m n q : ℕ) : (J m n q).IsJump` | PUBLIC |
| 9 | `Instr.shiftJumps_of_nonJump` | `{instr : Instr} (h : ¬instr.IsJump) (offset : ℕ) : instr.shiftJumps offset = instr` | PUBLIC |
| 10 | `Instr.jumpsBoundedBy_of_nonJump` | `{instr : Instr} (h : ¬instr.IsJump) (len : ℕ) : instr.JumpsBoundedBy len` | PUBLIC |
| 11 | `Instr.JumpsBoundedBy.mono` | `(h : instr.JumpsBoundedBy len1) (hle : len1 ≤ len2) : instr.JumpsBoundedBy len2` | PUBLIC |
| 12 | `Instr.JumpsBoundedBy.shiftJumps` | `(h : instr.JumpsBoundedBy len) : (instr.shiftJumps offset).JumpsBoundedBy (offset + len)` | PUBLIC |
| 13 | `Instr.JumpsBoundedBy.capJump` | `(len : ℕ) (instr : Instr) : (instr.capJump len).JumpsBoundedBy len` | PUBLIC |
| 14 | `Instr.capJump_idempotent` | `(len : ℕ) (instr : Instr) : (instr.capJump len).capJump len = instr.capJump len` | PUBLIC |
| 15 | `Instr.capJump_Z` | `(len n : ℕ) : (Z n).capJump len = Z n` | PUBLIC |
| 16 | `Instr.capJump_S` | `(len n : ℕ) : (S n).capJump len = S n` | PUBLIC |
| 17 | `Instr.capJump_T` | `(len m n : ℕ) : (T m n).capJump len = T m n` | PUBLIC |
| 18 | `Instr.capJump_J` | `(len m n q : ℕ) : (J m n q).capJump len = J m n (min q len)` | PUBLIC |
| 19 | `Program.mem_maxRegister` | `{p : Program} {instr : Instr} (h : instr ∈ p) : instr.maxRegister ≤ p.maxRegister` | PUBLIC |

## Statistics
- Theorems/Lemmas: 19
- Definitions: 3
- Lines of code: 187
- Imports: Cslib.Computability.URM.Defs, Mathlib.Data.List.MinMax
