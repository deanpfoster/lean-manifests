# Cslib.Foundations.Control.Monad.Free.Effects

## Module Summary

Implements State, Writer, Continuation, and Reader monads as canonical instances of `FreeM`. Each provides hand-written and canonical interpreters, proves they agree, and establishes uniqueness via the universal property.

## Vocabulary

| Name | Kind | Description |
|------|------|-------------|
| `StateF` | inductive | Effect signature for state: `get` and `set` |
| `FreeState` | abbrev | `FreeM (StateF σ)` -- state monad via free monad |
| `WriterF` | inductive | Effect signature for writer: `tell` |
| `FreeWriter` | abbrev | `FreeM (WriterF ω)` -- writer monad via free monad |
| `ContF` | inductive | Effect signature for continuations: `callCC` |
| `FreeCont` | abbrev | `FreeM (ContF r)` -- continuation monad via free monad |
| `ReaderF` | inductive | Effect signature for reader: `read` |
| `FreeReader` | abbrev | `FreeM (ReaderF σ)` -- reader monad via free monad |

## Theorems

### PUBLIC

| # | Name | Signature |
|---|------|-----------|
| 1 | `FreeState.run_toStateM` | `theorem FreeState.run_toStateM {α : Type u} (comp : FreeState σ α) (s₀ : σ) : (toStateM comp).run s₀ = pure (run comp s₀)` |
| 2 | `FreeState.toStateM_unique` | `theorem FreeState.toStateM_unique {α : Type u} (g : FreeState σ α → StateM σ α) (h : Interprets stateInterp g) : g = toStateM` |
| 3 | `FreeState.run_bind` | `lemma FreeState.run_bind (x : FreeState σ α) (f : α → FreeState σ β) (s₀ : σ) : run (x.bind f) s₀ = let p := x.run s₀; (f p.1).run p.2` |
| 4 | `FreeState.run'_toStateM` | `theorem FreeState.run'_toStateM {α : Type u} (comp : FreeState σ α) (s₀ : σ) : (toStateM comp).run' s₀ = pure (run' comp s₀)` |
| 5 | `FreeState.run'_bind` | `lemma FreeState.run'_bind (x : FreeState σ α) (f : α → FreeState σ β) (s₀ : σ) : run' (x.bind f) s₀ = let p := x.run s₀; (f p.1).run' p.2` |
| 6 | `FreeWriter.run_toWriterT` | `theorem FreeWriter.run_toWriterT {α : Type u} [Monoid ω] (comp : FreeWriter ω α) : (toWriterT comp).run = pure (run comp)` |
| 7 | `FreeWriter.toWriterT_unique` | `theorem FreeWriter.toWriterT_unique {α : Type u} [Monoid ω] (g : FreeWriter ω α → WriterT ω Id α) (h : Interprets writerInterp g) : g = toWriterT` |
| 8 | `FreeWriter.run_bind` | `lemma FreeWriter.run_bind [Monoid ω] (x : FreeWriter ω α) (f : α → FreeWriter ω β) : run (x.bind f) = let p := run x; ((f p.1).run.1, p.2 * (f p.1).run.2)` |
| 9 | `FreeCont.run_toContT` | `theorem FreeCont.run_toContT {α : Type u} (comp : FreeCont r α) (k : α → r) : (toContT comp).run k = pure (run comp k)` |
| 10 | `FreeCont.toContT_unique` | `theorem FreeCont.toContT_unique {α : Type u} (g : FreeCont r α → ContT r Id α) (h : Interprets contInterp g) : g = toContT` |
| 11 | `FreeCont.run_bind` | `lemma FreeCont.run_bind (x : FreeCont r α) (f : α → FreeCont r β) (k : β → r) : run (x.bind f) k = run x (fun i => run (f i) k)` |
| 12 | `FreeReader.run_toReaderM` | `theorem FreeReader.run_toReaderM {α : Type u} (comp : FreeReader σ α) (s : σ) : (toReaderM comp).run s = pure (run comp s)` |
| 13 | `FreeReader.toReaderM_unique` | `theorem FreeReader.toReaderM_unique {α : Type u} (g : FreeReader σ α → ReaderM σ α) (h : Interprets readInterp g) : g = toReaderM` |
| 14 | `FreeReader.run_bind` | `lemma FreeReader.run_bind (x : FreeReader σ α) (f : α → FreeReader σ β) (s₀ : σ) : run (x.bind f) s₀ = run (f <| run x s₀) s₀` |
| 15 | `FreeReader.run_withReader` | `theorem FreeReader.run_withReader (f : σ → σ) (m : FreeReader σ α) (s : σ) : run (withTheReader σ f m) s = run m (f s)` |

### INTERNAL

| # | Name | Signature |
|---|------|-----------|
| 1 | `FreeState.get_def` | `lemma FreeState.get_def : (get : FreeState σ σ) = .lift .get` |
| 2 | `FreeState.set_def` | `lemma FreeState.set_def (s : σ) : (set s : FreeState σ PUnit) = .lift (.set s)` |
| 3 | `FreeState.run_pure` | `lemma FreeState.run_pure (a : α) (s₀ : σ) : run (.pure a : FreeState σ α) s₀ = (a, s₀)` |
| 4 | `FreeState.run_get` | `lemma FreeState.run_get (k : σ → FreeState σ α) (s₀ : σ) : run (liftBind .get k) s₀ = run (k s₀) s₀` |
| 5 | `FreeState.run_set` | `lemma FreeState.run_set (s' : σ) (k : PUnit → FreeState σ α) (s₀ : σ) : run (liftBind (.set s') k) s₀ = run (k .unit) s'` |
| 6 | `FreeWriter.run_pure` | `lemma FreeWriter.run_pure [Monoid ω] (a : α) : run (.pure a : FreeWriter ω α) = (a, 1)` |
| 7 | `FreeWriter.listen_pure` | `lemma FreeWriter.listen_pure [Monoid ω] (a : α) : listen (.pure a : FreeWriter ω α) = .pure (a, 1)` |
| 8 | `FreeCont.run_pure` | `lemma FreeCont.run_pure (a : α) (k : α → r) : run (.pure a : FreeCont r α) k = k a` |
| 9 | `FreeReader.run_pure` | `lemma FreeReader.run_pure (a : α) (s₀ : σ) : run (.pure a : FreeReader σ α) s₀ = a` |
| 10 | `FreeReader.run_read` | `lemma FreeReader.run_read (k : σ → FreeReader σ α) (s₀ : σ) : run (liftBind .read k) s₀ = run (k s₀) s₀` |
| 11 | `FreeReader.read_def` | `lemma FreeReader.read_def : (read : FreeReader σ σ) = .lift .read` |

## Counts

- **PUBLIC**: 15
- **INTERNAL**: 11
