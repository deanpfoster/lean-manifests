# Cslib.Computability.Automata.EpsilonNA.ToNA

## Summary
Implements the translation of epsilon-NA into NA by removing epsilon-transitions (using saturated transitions on the underlying LTS). Proves the resulting NA.FinAcc has the same language.

## Vocabulary
| Name | Kind | Description |
|------|------|-------------|
| `LTS.noε` | def | Removes epsilon-transitions from an Option-labelled LTS |
| `εNA.FinAcc.toNAFinAcc` | def | Converts an epsilon-NA.FinAcc to an NA.FinAcc |

## Theorems

| # | Name | Signature | Visibility |
|---|------|-----------|------------|
| 1 | `LTS.noε_saturate_mTr` | `{lts : LTS State (Option Label)} : lts.saturate.MTr s (μs.map some) = lts.saturate.noε.MTr s μs` | PUBLIC |
| 2 | `toNAFinAcc_language_eq` | `{ena : εNA.FinAcc State Symbol} : language ena.toNAFinAcc = language ena` | PUBLIC |

## Statistics
- Theorems/Lemmas: 2 (plus 1 private lemma)
- Definitions: 2
- Lines of code: 62
- Imports: Cslib.Computability.Automata.EpsilonNA.Basic
