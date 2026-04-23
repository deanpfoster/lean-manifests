import Cslib.Algorithms.Lean.MergeSort.MergeSort

open Cslib.Algorithms.Lean Cslib.Algorithms.Lean.TimeM

-- Bridge: CSLib theorems → _proof naming convention
-- If CSLib changes a type, this file fails to compile.

noncomputable def sorted_merge_proof := @sorted_merge
noncomputable def mergeSort_sorted_proof := @mergeSort_sorted
noncomputable def mergeSort_perm_proof := @mergeSort_perm
noncomputable def mergeSort_correct_proof := @mergeSort_correct
noncomputable def merge_time_proof := @merge_time
noncomputable def mergeSort_same_length_proof := @mergeSort_same_length
noncomputable def mergeSort_time_proof := @mergeSort_time
