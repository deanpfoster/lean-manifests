# Cslib.Computability.Machines.SingleTapeTuring.Basic

## Summary
Defines single-tape Turing machines over a finite alphabet with bidirectional infinite tape, including configurations, step function, time-bounded computability, and polynomial-time computability. Proves composition of polynomial-time machines yields polynomial-time machines.

## Vocabulary
| Name | Kind | Description |
|------|------|-------------|
| `SingleTapeTM.Stmt` | structure | Write symbol + optional move direction |
| `SingleTapeTM` | structure | TM with State, initial state, transition function |
| `SingleTapeTM.Cfg` | structure | Configuration: optional state + BiTape |
| `SingleTapeTM.step` | def | Single-step transition function |
| `SingleTapeTM.initCfg` | def | Initial configuration from input list |
| `SingleTapeTM.haltCfg` | def | Halting configuration with output list |
| `SingleTapeTM.TransitionRelation` | def | Step relation as a Prop |
| `SingleTapeTM.Outputs` | def | TM outputs l' on input l (via ReflTransGen) |
| `SingleTapeTM.OutputsWithinTime` | def | TM outputs l' on input l within m steps |
| `SingleTapeTM.idComputer` | def | Identity TM |
| `SingleTapeTM.compComputer` | def | Composition of two TMs |
| `TimeComputable` | structure | TM + time bound + correctness proof |
| `PolyTimeComputable` | structure | TimeComputable + polynomial bound |

## Theorems / Lemmas

| # | Name | Signature | Visibility |
|---|------|-----------|------------|
| 1 | `Cfg.space_used_initCfg` | `(tm : SingleTapeTM Symbol) (s : List Symbol) : (tm.initCfg s).space_used = max 1 s.length` | PUBLIC |
| 2 | `Cfg.space_used_haltCfg` | `(tm : SingleTapeTM Symbol) (s : List Symbol) : (tm.haltCfg s).space_used = max 1 s.length` | PUBLIC |
| 3 | `Cfg.space_used_step` | `{tm : SingleTapeTM Symbol} (cfg cfg' : tm.Cfg) (hstep : tm.step cfg = some cfg') : cfg'.space_used ≤ cfg.space_used + 1` | PUBLIC |
| 4 | `output_length_le_input_length_add_time` | `(tm : SingleTapeTM Symbol) (l l' : List Symbol) (t : ℕ) (h : tm.OutputsWithinTime l l' t) : l'.length ≤ max 1 l.length + t` | PUBLIC |
| 5 | `compComputer_q₀_eq` | `(compComputer tm1 tm2).q₀ = Sum.inl tm1.q₀` | INTERNAL |
| 6 | `map_toCompCfg_left_step` | private: left converting function commutes with steps | INTERNAL |
| 7 | `map_toCompCfg_right_step` | private: right converting function commutes with steps | INTERNAL |
| 8 | `comp_left_relatesWithinSteps` | private: simulation for first phase | INTERNAL |
| 9 | `comp_right_relatesWithinSteps` | private: simulation for second phase | INTERNAL |

## Constructions

| # | Name | Signature | Visibility |
|---|------|-----------|------------|
| 1 | `TimeComputable.id` | `TimeComputable (Symbol := Symbol) id` | PUBLIC |
| 2 | `TimeComputable.comp` | `(hf : TimeComputable f) (hg : TimeComputable g) (h_mono : Monotone hg.time_bound) : TimeComputable (g ∘ f)` | PUBLIC |
| 3 | `PolyTimeComputable.id` | `PolyTimeComputable (Symbol := Symbol) id` | PUBLIC |
| 4 | `PolyTimeComputable.comp` | `(hf : PolyTimeComputable f) (hg : PolyTimeComputable g) (h_mono : Monotone hg.time_bound) : PolyTimeComputable (g ∘ f)` | PUBLIC |

## Statistics
- Theorems/Lemmas: 9 (4 public, 5 internal/private)
- Definitions/Structures: 13
- Constructions: 4
- Lines of code: 511
- Imports: Cslib.Foundations.Data.BiTape, Cslib.Foundations.Data.RelatesInSteps, Mathlib.Algebra.Polynomial.Eval.Defs
