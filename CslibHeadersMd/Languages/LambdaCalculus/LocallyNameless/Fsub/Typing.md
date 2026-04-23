# LambdaCalculus.LocallyNameless.Fsub.Typing

Defines the typing relation for System F-sub and proves weakening, narrowing, term/type substitution, inversion lemmas, and canonical forms.

## Vocabulary

| Name | Kind | Description |
|------|------|-------------|
| `Typing` | inductive | Typing judgement (10 rules: var, abs, app, tabs, tapp, sub, let', inl, inr, case) |

## Theorems (selected)

| # | Name | Signature | Visibility |
|---|------|-----------|------------|
| 1 | `Typing.wf` | `Typing Γ t τ → Γ.Wf ∧ t.LC ∧ τ.Wf Γ` | PUBLIC |
| 2 | `Typing.weaken` | weakening | PUBLIC |
| 3 | `Typing.narrow` | narrowing | PUBLIC |
| 4 | `Typing.subst_tm` | term substitution | PUBLIC |
| 5 | `Typing.subst_ty` | type substitution | PUBLIC |
| 6 | `Typing.canonical_form_abs` | `Value t → Typing [] t (arrow σ τ) → ∃ δ t', t = .abs δ t'` | PUBLIC |
| 7 | `Typing.canonical_form_tabs` | canonical form for type abstractions | PUBLIC |
| 8 | `Typing.canonical_form_sum` | canonical form for sum types | PUBLIC |

## Statistics

- **Theorems/Lemmas**: 8+
- **Lines of code**: 244
- **Authors**: Chris Henson
