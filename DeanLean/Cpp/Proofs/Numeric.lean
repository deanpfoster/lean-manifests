import DeanLean.Cpp.Code.Numeric

namespace Cpp

/-! ## numeric_limits property proofs -/

/-- UInt8: min ≤ max -/
theorem NumericLimits.min_le_max_UInt8_proof :
    NumericLimits.min_le_max_prop UInt8 := by
  simp [NumericLimits.min_le_max_prop, IntPromotable.toInt, NumericLimits.min, NumericLimits.max]

/-- UInt16: min ≤ max -/
theorem NumericLimits.min_le_max_UInt16_proof :
    NumericLimits.min_le_max_prop UInt16 := by
  simp [NumericLimits.min_le_max_prop, IntPromotable.toInt, NumericLimits.min, NumericLimits.max]

/-- UInt32: min ≤ max -/
theorem NumericLimits.min_le_max_UInt32_proof :
    NumericLimits.min_le_max_prop UInt32 := by
  simp [NumericLimits.min_le_max_prop, IntPromotable.toInt, NumericLimits.min, NumericLimits.max]

/-- UInt64: min ≤ max -/
theorem NumericLimits.min_le_max_UInt64_proof :
    NumericLimits.min_le_max_prop UInt64 := by
  simp [NumericLimits.min_le_max_prop, IntPromotable.toInt, NumericLimits.min, NumericLimits.max]

/-- Int8: min ≤ max -/
theorem NumericLimits.min_le_max_Int8_proof :
    NumericLimits.min_le_max_prop Int8 := by
  simp [NumericLimits.min_le_max_prop, IntPromotable.toInt, NumericLimits.min, NumericLimits.max]

/-- Int16: min ≤ max -/
theorem NumericLimits.min_le_max_Int16_proof :
    NumericLimits.min_le_max_prop Int16 := by
  simp [NumericLimits.min_le_max_prop, IntPromotable.toInt, NumericLimits.min, NumericLimits.max]

/-- Int32: min ≤ max -/
theorem NumericLimits.min_le_max_Int32_proof :
    NumericLimits.min_le_max_prop Int32 := by
  simp [NumericLimits.min_le_max_prop, IntPromotable.toInt, NumericLimits.min, NumericLimits.max]

/-- Int64: min ≤ max -/
theorem NumericLimits.min_le_max_Int64_proof :
    NumericLimits.min_le_max_prop Int64 := by
  simp [NumericLimits.min_le_max_prop, IntPromotable.toInt, NumericLimits.min, NumericLimits.max]

/-! ## digits > 0 proofs -/

theorem NumericLimits.digits_pos_UInt8_proof :
    NumericLimits.digits_pos_prop UInt8 := by
  simp [NumericLimits.digits_pos_prop, NumericLimits.digits]

theorem NumericLimits.digits_pos_UInt16_proof :
    NumericLimits.digits_pos_prop UInt16 := by
  simp [NumericLimits.digits_pos_prop, NumericLimits.digits]

theorem NumericLimits.digits_pos_UInt32_proof :
    NumericLimits.digits_pos_prop UInt32 := by
  simp [NumericLimits.digits_pos_prop, NumericLimits.digits]

theorem NumericLimits.digits_pos_UInt64_proof :
    NumericLimits.digits_pos_prop UInt64 := by
  simp [NumericLimits.digits_pos_prop, NumericLimits.digits]

theorem NumericLimits.digits_pos_Int8_proof :
    NumericLimits.digits_pos_prop Int8 := by
  simp [NumericLimits.digits_pos_prop, NumericLimits.digits]

theorem NumericLimits.digits_pos_Int16_proof :
    NumericLimits.digits_pos_prop Int16 := by
  simp [NumericLimits.digits_pos_prop, NumericLimits.digits]

theorem NumericLimits.digits_pos_Int32_proof :
    NumericLimits.digits_pos_prop Int32 := by
  simp [NumericLimits.digits_pos_prop, NumericLimits.digits]

theorem NumericLimits.digits_pos_Int64_proof :
    NumericLimits.digits_pos_prop Int64 := by
  simp [NumericLimits.digits_pos_prop, NumericLimits.digits]

/-! ## is_signed correctness proofs -/

theorem NumericLimits.is_signed_correct_Int8_proof :
    NumericLimits.is_signed_correct_prop Int8 := by
  simp [NumericLimits.is_signed_correct_prop, IntPromotable.toInt, NumericLimits.min,
        NumericLimits.is_signed]

theorem NumericLimits.is_signed_correct_Int16_proof :
    NumericLimits.is_signed_correct_prop Int16 := by
  simp [NumericLimits.is_signed_correct_prop, IntPromotable.toInt, NumericLimits.min,
        NumericLimits.is_signed]

theorem NumericLimits.is_signed_correct_Int32_proof :
    NumericLimits.is_signed_correct_prop Int32 := by
  simp [NumericLimits.is_signed_correct_prop, IntPromotable.toInt, NumericLimits.min,
        NumericLimits.is_signed]

theorem NumericLimits.is_signed_correct_Int64_proof :
    NumericLimits.is_signed_correct_prop Int64 := by
  simp [NumericLimits.is_signed_correct_prop, IntPromotable.toInt, NumericLimits.min,
        NumericLimits.is_signed]

theorem NumericLimits.unsigned_min_nonneg_UInt8_proof :
    NumericLimits.unsigned_min_nonneg_prop UInt8 := by
  simp [NumericLimits.unsigned_min_nonneg_prop, IntPromotable.toInt, NumericLimits.min,
        NumericLimits.is_signed]

theorem NumericLimits.unsigned_min_nonneg_UInt16_proof :
    NumericLimits.unsigned_min_nonneg_prop UInt16 := by
  simp [NumericLimits.unsigned_min_nonneg_prop, IntPromotable.toInt, NumericLimits.min,
        NumericLimits.is_signed]

theorem NumericLimits.unsigned_min_nonneg_UInt32_proof :
    NumericLimits.unsigned_min_nonneg_prop UInt32 := by
  simp [NumericLimits.unsigned_min_nonneg_prop, IntPromotable.toInt, NumericLimits.min,
        NumericLimits.is_signed]

theorem NumericLimits.unsigned_min_nonneg_UInt64_proof :
    NumericLimits.unsigned_min_nonneg_prop UInt64 := by
  simp [NumericLimits.unsigned_min_nonneg_prop, IntPromotable.toInt, NumericLimits.min,
        NumericLimits.is_signed]

/-! ## cmp_equal correctness -/

theorem cmp_equal_correct_proof {T U : Type} [IntPromotable T] [IntPromotable U]
    (t : T) (u : U) :
    cmp_equal_correct_prop t u := by
  unfold cmp_equal_correct_prop cmp_equal
  constructor
  · intro h; exact of_decide_eq_true h
  · intro h; exact decide_eq_true h

/-! ## cmp_less correctness -/

theorem cmp_less_correct_proof {T U : Type} [IntPromotable T] [IntPromotable U]
    (t : T) (u : U) :
    cmp_less_correct_prop t u := by
  unfold cmp_less_correct_prop cmp_less
  constructor
  · intro h; exact of_decide_eq_true h
  · intro h; exact decide_eq_true h

/-! ## cmp_greater = flip of cmp_less -/

theorem cmp_greater_flip_proof {T U : Type} [IntPromotable T] [IntPromotable U]
    (t : T) (u : U) :
    cmp_greater_flip_prop t u := by
  simp [cmp_greater_flip_prop, cmp_greater]

end Cpp
