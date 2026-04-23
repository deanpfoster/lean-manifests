# Cslib.Foundations.Data.StackTape

## Module Summary

Defines `StackTape`, an infinite eventually-`none` tape represented as a `List (Option Symbol)` that cannot end with `none`. Provides `cons`, `tail`, `head`, `map_some`, and `length` operations.

## Vocabulary

| Name | Kind | Description |
|------|------|-------------|
| `StackTape` | structure | List of `Option Symbol` not ending with `none`; represents infinite tape |
| `StackTape.nil` | def | The empty `StackTape` |
| `StackTape.cons` | def | Prepend an `Option Symbol` |
| `StackTape.tail` | def | Remove the first element |
| `StackTape.head` | def | Get the first element |
| `StackTape.map_some` | def | Create from a `List Symbol` by mapping all to `some` |
| `StackTape.length` | def | Number of elements up to last non-`none` |

## Theorems

### PUBLIC

| # | Name | Signature |
|---|------|-----------|
| 1 | `empty_eq_nil` | `lemma empty_eq_nil : (empty : StackTape Symbol) = nil` |
| 2 | `nil_toList` | `lemma nil_toList : (nil : StackTape Symbol).toList = []` |
| 3 | `cons_none_nil_toList` | `lemma cons_none_nil_toList : (cons none (nil : StackTape Symbol)).toList = []` |
| 4 | `cons_some_toList` | `lemma cons_some_toList (a : Symbol) (l : StackTape Symbol) : (cons (some a) l).toList = some a :: l.toList` |
| 5 | `eq_iff` | `lemma eq_iff (l1 l2 : StackTape Symbol) : l1 = l2 <-> l1.head = l2.head and l1.tail = l2.tail` |
| 6 | `head_cons` | `lemma head_cons (o : Option Symbol) (l : StackTape Symbol) : (cons o l).head = o` |
| 7 | `tail_cons` | `lemma tail_cons (o : Option Symbol) (l : StackTape Symbol) : (cons o l).tail = l` |
| 8 | `cons_head_tail` | `lemma cons_head_tail (l : StackTape Symbol) : cons (l.head) (l.tail) = l` |
| 9 | `length_tail_le` | `lemma length_tail_le (l : StackTape Symbol) : l.tail.length <= l.length` |
| 10 | `length_cons_none` | `lemma length_cons_none (l : StackTape Symbol) : (cons none l).length = l.length + if l.length = 0 then 0 else 1` |
| 11 | `length_cons_some` | `lemma length_cons_some (a : Symbol) (l : StackTape Symbol) : (cons (some a) l).length = l.length + 1` |
| 12 | `length_cons_le` | `lemma length_cons_le (o : Option Symbol) (l : StackTape Symbol) : (cons o l).length <= l.length + 1` |
| 13 | `length_map_some` | `lemma length_map_some (l : List Symbol) : (map_some l).length = l.length` |
| 14 | `length_nil` | `lemma length_nil : (nil : StackTape Symbol).length = 0` |

### INTERNAL

None.

## Counts

- **PUBLIC**: 14
- **INTERNAL**: 0
