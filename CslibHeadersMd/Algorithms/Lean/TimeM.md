# Algorithms.Lean.TimeM

A monad for tracking time complexity of computations. `TimeM T α` pairs a return value with an accumulated cost.

## Vocabulary

| Name | Kind | Description |
|------|------|-------------|
| `TimeM` | structure | `{ret : α, time : T}` — computation with tracked cost |
| `TimeM.pure` | def | Lift a value with zero cost |
| `TimeM.bind` | def | Sequential composition, summing costs |
| `TimeM.tick` | def | A computation with cost `c` and unit return |

## Theorems

| # | Name | Signature | Visibility |
|---|------|-----------|------------|
| 1 | `ret_pure` | `(pure a : TimeM T α).ret = a` | PUBLIC |
| 2 | `ret_bind` | `(m >>= f).ret = (f m.ret).ret` | PUBLIC |
| 3 | `time_bind` | `(m >>= f).time = m.time + (f m.ret).time` | PUBLIC |
| 4 | `LawfulMonad` | instance: `TimeM T` is a lawful monad when `T` is an `AddMonoid` | PUBLIC |

## Statistics

- **Theorems/Lemmas**: 4 + many simp lemmas
- **Lines of code**: 143
- **Authors**: Sorrachai Yingchareonthawornhcai, Eric Wieser
