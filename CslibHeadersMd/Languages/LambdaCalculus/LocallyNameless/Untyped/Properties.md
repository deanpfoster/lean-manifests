# LambdaCalculus.LocallyNameless.Untyped.Properties

Core metatheoretic properties of the locally nameless representation: substitution distributes over opening, local closure is preserved by substitution and opening, and open/close are inverses.

## Theorems

| # | Name | Signature | Visibility |
|---|------|-----------|------------|
| 1 | `subst_fresh` | `x ∉ t.fv → t[x := sub] = t` | PUBLIC |
| 2 | `open_close` | `x ∉ t.fv → t = t⟦k ↝ fvar x⟧⟦k ↜ x⟧` | PUBLIC |
| 3 | `open_injective` | `x ∉ M.fv → x ∉ M'.fv → M ^ fvar x = M' ^ fvar x → M = M'` | PUBLIC |
| 4 | `open_lc` | `e.LC → e = e⟦k ↝ t⟧` | PUBLIC |
| 5 | `subst_openRec` | `LC t → (e⟦k ↝ u⟧)[x := t] = e[x := t]⟦k ↝ u[x := t]⟧` | PUBLIC |
| 6 | `subst_lc` | `e.LC → u.LC → LC (e[x := u])` | PUBLIC |
| 7 | `beta_lc` | `M.abs.LC → N.LC → LC (M ^ N)` | PUBLIC |
| 8 | `subst_intro` | `x ∉ e.fv → t.LC → e ^ t = (e ^ fvar x)[x := t]` | PUBLIC |
| 9 | `close_open` | `t.LC → t⟦k ↜ x⟧⟦k ↝ fvar x⟧ = t` | PUBLIC |

## Statistics

- **Theorems/Lemmas**: 9 major + many auxiliary
- **Lines of code**: 159
- **Authors**: Chris Henson
