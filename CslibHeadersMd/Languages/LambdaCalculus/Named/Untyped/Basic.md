# LambdaCalculus.Named.Untyped.Basic

The untyped lambda-calculus with named variables: syntax, substitution, renaming, contexts, and alpha-equivalence.

## Vocabulary

| Name | Kind | Description |
|------|------|-------------|
| `Term` | inductive | Lambda terms: var, abs, app |
| `Term.fv`, `Term.bv`, `Term.vars` | def | Free, bound, and all variables |
| `Term.Subst` | inductive | Capture-avoiding substitution as an inference system |
| `Term.rename` | def | Variable renaming |
| `Term.subst` | def | Capture-avoiding substitution (function) |
| `Context` | inductive | Single-hole contexts: hole, abs, appL, appR |
| `Context.fill` | def | Fill a context with a term |
| `Term.AlphaEquiv` | inductive | Alpha-equivalence (axiom, refl, symm, trans, ctx) |

## Theorems

| # | Name | Signature | Visibility |
|---|------|-----------|------------|
| 1 | `Term.rename.eq_sizeOf` | `sizeOf (m.rename x y) = sizeOf m` | PUBLIC |
| 2 | `Context.complete` | `(m : Term Var) → ∃ c x, m = c.fill (Term.var x)` | PUBLIC |

## Statistics

- **Theorems/Lemmas**: 2
- **Definitions**: 10+
- **Lines of code**: 166
- **Authors**: Fabrizio Montesi
