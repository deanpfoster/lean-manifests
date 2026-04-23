# LambdaCalculus.LocallyNameless.Fsub.Basic

Defines the syntax of System F-sub (polymorphic lambda calculus with subtyping) using locally nameless representation: types, terms, bindings, and free variable functions.

## Vocabulary

| Name | Kind | Description |
|------|------|-------------|
| `Ty` | inductive | Types: top, bvar, fvar, arrow, all, sum |
| `Term` | inductive | Terms: bvar, fvar, abs, app, tabs, tapp, let', inl, inr, case |
| `Binding` | inductive | Context bindings: sub (subtype) or ty (type) |
| `Env` | abbrev | Environment: `Context Var (Binding Var)` |

## Statistics

- **Definitions**: 4 inductives + free variable functions
- **Lines of code**: 115
- **Authors**: Chris Henson
