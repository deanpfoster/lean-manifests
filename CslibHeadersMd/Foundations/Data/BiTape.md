# Cslib.Foundations.Data.BiTape

## Module Summary

Defines `BiTape`, a bidirectionally-infinite Turing machine tape using `StackTape` for left/right contents. Provides move, write, and space-usage operations.

## Vocabulary

| Name | Kind | Description |
|------|------|-------------|
| `BiTape` | structure | Tape with a head symbol and left/right `StackTape` contents |
| `BiTape.nil` | def | The empty `BiTape` |
| `BiTape.mk₁` | def | Construct a `BiTape` from a `List Symbol` |
| `BiTape.move_left` | def | Move tape head left |
| `BiTape.move_right` | def | Move tape head right |
| `BiTape.move` | def | Move tape head by `Dir` |
| `BiTape.optionMove` | def | Optionally perform a move |
| `BiTape.write` | def | Write a symbol at the head |
| `BiTape.space_used` | def | Number of symbols between leftmost and rightmost non-blank |

## Theorems

### PUBLIC

| # | Name | Signature |
|---|------|-----------|
| 1 | `empty_eq_nil` | `lemma empty_eq_nil : (∅ : BiTape Symbol) = nil` |
| 2 | `move_left_move_right` | `lemma move_left_move_right (t : BiTape Symbol) : t.move_left.move_right = t` |
| 3 | `move_right_move_left` | `lemma move_right_move_left (t : BiTape Symbol) : t.move_right.move_left = t` |
| 4 | `space_used_write` | `lemma space_used_write (t : BiTape Symbol) (a : Option Symbol) : (t.write a).space_used = t.space_used` |
| 5 | `space_used_mk₁` | `lemma space_used_mk₁ (l : List Symbol) : (mk₁ l).space_used = max 1 l.length` |
| 6 | `space_used_move` | `lemma space_used_move (t : BiTape Symbol) (d : Dir) : (t.move d).space_used ≤ t.space_used + 1` |

### INTERNAL

None.

## Counts

- **PUBLIC**: 6
- **INTERNAL**: 0
