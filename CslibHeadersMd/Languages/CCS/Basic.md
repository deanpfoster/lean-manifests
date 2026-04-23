# CCS.Basic

Defines the syntax of Milner's Calculus of Communicating Systems (CCS): actions, processes, and single-hole contexts. Proves that contexts completely capture CCS syntax.

## Vocabulary

| Name | Kind | Description |
|------|------|-------------|
| `CCS.Act` | inductive | Actions: `name a`, `coname a`, or `τ` |
| `CCS.Process` | inductive | Processes: nil, prefix, parallel, choice, restriction, constant |
| `CCS.Context` | inductive | Single-hole contexts for CCS processes |
| `CCS.Act.IsVisible` | inductive | Predicate for visible (non-τ) actions |
| `CCS.Act.Co` | inductive | Co-action relation between two actions |
| `CCS.Act.isCo` | def | Boolean co-action check |
| `CCS.Context.fill` | def | Fills a context hole with a process |
| `HasContext` | instance | CCS processes have contexts |

## Theorems

| # | Name | Signature | Visibility |
|---|------|-----------|------------|
| 1 | `Act.isVisible_neq_τ` | `{μ : Act Name} → μ.IsVisible → μ ≠ Act.τ` | PUBLIC |
| 2 | `Act.Co.symm` | `Act.Co μ μ' → Act.Co μ' μ` | PUBLIC |
| 3 | `Act.co_isVisible` | `Act.Co μ μ' → μ.IsVisible ∧ μ'.IsVisible` | PUBLIC |
| 4 | `Act.isCo_iff` | `[DecidableEq Name] → {μ μ' : Act Name} → isCo μ μ' ↔ Co μ μ'` | PUBLIC |
| 5 | `context_fill_def` | `(c : Context Name Constant) → (p : Process Name Constant) → c<[p] = c.fill p` | PUBLIC |
| 6 | `Context.complete` | `(p : Process Name Constant) → ∃ c, p = c<[Process.nil] ∨ ∃ k, p = c<[Process.const k]` | PUBLIC |

## Statistics

- **Theorems/Lemmas**: 6
- **Definitions**: 7 (3 inductives, 2 defs, 2 instances)
- **Lines of code**: 158
- **Authors**: Fabrizio Montesi
