# CombinatoryLogic.List

Church-encoded lists in SKI combinatory logic for proving SKI-TM equivalence. Defines nil, cons, head, tail, and helper operations on Church-encoded lists of natural numbers.

## Vocabulary

| Name | Kind | Description |
|------|------|-------------|
| `IsChurchList` | def | A term correctly Church-encodes a list of naturals |
| `List.Nil` | def | SKI term for empty list |
| `List.Cons` | def | SKI term for list cons |
| `List.HeadD`, `List.Head` | def | List head with default / default 0 |
| `List.Tail` | def | List tail via fold |
| `List.toChurch` | def | Canonical SKI encoding of a list |

## Theorems

| # | Name | Signature | Visibility |
|---|------|-----------|------------|
| 1 | `nil_correct` | `IsChurchList [] Nil` | PUBLIC |
| 2 | `cons_correct` | `IsChurch x cx → IsChurchList xs cxs → IsChurchList (x :: xs) (Cons ⬝ cx ⬝ cxs)` | PUBLIC |
| 3 | `toChurch_correct` | `IsChurchList ns (toChurch ns)` | PUBLIC |
| 4 | `headD_correct` | `IsChurch d cd → IsChurchList ns cns → IsChurch (ns.headD d) (HeadD ⬝ cd ⬝ cns)` | PUBLIC |
| 5 | `tail_correct` | `IsChurchList ns cns → IsChurchList ns.tail (Tail ⬝ cns)` | PUBLIC |
| 6 | `succHead_correct` | `IsChurchList ns cns → IsChurchList [ns.headD 0 + 1] (SuccHead ⬝ cns)` | PUBLIC |

## Statistics

- **Theorems/Lemmas**: 6 major + several auxiliary
- **Lines of code**: 280
- **Authors**: Jesse Alama
