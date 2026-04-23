import CslibHeaders.Basic
import Cslib.Foundations.Control.Monad.Free.Effects

/-! # Free Monad Effect Instances: State, Writer, Continuation, Reader

  ## Vocabulary
  - `Cslib.FreeM.FreeState σ` — state monad via `FreeM`
  - `Cslib.FreeM.FreeWriter ω` — writer monad via `FreeM`
  - `Cslib.FreeM.FreeCont r` — continuation monad via `FreeM`
  - `Cslib.FreeM.FreeReader σ` — reader monad via `FreeM`

  Each monad provides:
  - A hand-written interpreter (`run`)
  - A canonical interpreter via `liftM` (`toStateM`, `toWriterT`, `toContT`, `toReaderM`)
  - A proof that they agree (`run_toStateM`, `run_toWriterT`, `run_toContT`, `run_toReaderM`)
  - A uniqueness theorem for the canonical interpreter
-/

open Cslib Cslib.FreeM

universe u v

-- ════════════════════════════════════════════
-- State monad: run agrees with canonical
-- ════════════════════════════════════════════

ExternalTheorem freeState_run_toStateM
  := @Cslib.FreeM.FreeState.run_toStateM
  : ∀ {σ : Type u} {α : Type u} (comp : FreeState σ α) (s₀ : σ),
    (FreeState.toStateM comp).run s₀ = pure (FreeState.run comp s₀)

ExternalTheorem freeState_toStateM_unique
  := @Cslib.FreeM.FreeState.toStateM_unique
  : ∀ {σ : Type u} {α : Type u} (g : FreeState σ α → StateM σ α),
    FreeM.Interprets FreeState.stateInterp g → g = FreeState.toStateM

-- ════════════════════════════════════════════
-- Writer monad: run agrees with canonical
-- ════════════════════════════════════════════

ExternalTheorem freeWriter_run_toWriterT
  := @Cslib.FreeM.FreeWriter.run_toWriterT
  : ∀ {ω : Type u} {α : Type u} [inst : Monoid ω] (comp : FreeWriter ω α),
    (FreeWriter.toWriterT comp).run = pure (FreeWriter.run comp)

ExternalTheorem freeWriter_toWriterT_unique
  := @Cslib.FreeM.FreeWriter.toWriterT_unique
  : ∀ {ω : Type u} {α : Type u} [inst : Monoid ω] (g : FreeWriter ω α → WriterT ω Id α),
    FreeM.Interprets FreeWriter.writerInterp g → g = FreeWriter.toWriterT

-- ════════════════════════════════════════════
-- Continuation monad: run agrees with canonical
-- ════════════════════════════════════════════

ExternalTheorem freeCont_run_toContT
  := @Cslib.FreeM.FreeCont.run_toContT
  : ∀ {r : Type u} {α : Type u} (comp : FreeCont r α) (k : α → r),
    (FreeCont.toContT comp).run k = pure (FreeCont.run comp k)

ExternalTheorem freeCont_toContT_unique
  := @Cslib.FreeM.FreeCont.toContT_unique
  : ∀ {r : Type u} {α : Type u} (g : FreeCont r α → ContT r Id α),
    FreeM.Interprets FreeCont.contInterp g → g = FreeCont.toContT

-- ════════════════════════════════════════════
-- Reader monad: run agrees with canonical
-- ════════════════════════════════════════════

ExternalTheorem freeReader_run_toReaderM
  := @Cslib.FreeM.FreeReader.run_toReaderM
  : ∀ {σ : Type u} {α : Type u} (comp : FreeReader σ α) (s : σ),
    (FreeReader.toReaderM comp).run s = pure (FreeReader.run comp s)

ExternalTheorem freeReader_toReaderM_unique
  := @Cslib.FreeM.FreeReader.toReaderM_unique
  : ∀ {σ : Type u} {α : Type u} (g : FreeReader σ α → ReaderM σ α),
    FreeM.Interprets FreeReader.readInterp g → g = FreeReader.toReaderM
