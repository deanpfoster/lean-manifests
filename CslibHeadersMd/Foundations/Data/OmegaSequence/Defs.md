# Cslib.Foundations.Data.OmegaSequence.Defs

## Module Summary

Defines `omegaSequence alpha`, a wrapper around `Nat -> alpha` for infinite sequences, with core operations: `head`, `tail`, `drop`, `take`, `extract`, `cons`, `appendomegaSequence`, `const`, `map`, `zip`, and `iterate`.

## Vocabulary

| Name | Kind | Description |
|------|------|-------------|
| `omegaSequence` | structure | Infinite sequence of elements of `alpha`, wrapping `get : Nat -> alpha` |
| `omegaSequence.head` | abbrev | First element: `s 0` |
| `omegaSequence.tail` | def | Drop the first element |
| `omegaSequence.drop` | def | Drop first `n` elements |
| `omegaSequence.take` | def | Take first `n` elements as a `List` |
| `omegaSequence.extract` | def | Sub-list from position `m` to `n - 1` |
| `omegaSequence.cons` | def | Prepend an element |
| `omegaSequence.appendomegaSequence` | def | Append an omega-sequence to a list |
| `omegaSequence.const` | def | Constant omega-sequence |
| `omegaSequence.map` | def | Apply a function to all elements |
| `omegaSequence.zip` | def | Zip two omega-sequences with a binary operation |
| `omegaSequence.iterate` | def | Iterates of a function as an omega-sequence |

## Theorems

None (definitions only).

## Counts

- **PUBLIC**: 0
- **INTERNAL**: 0
