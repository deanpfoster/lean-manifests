import DeanLean.Cpp.Code.Expected

namespace Cpp.Expected

variable {T U V E E2 : Type}

theorem has_value_ok_proof (v : T) : (Expected.ok v : Expected E T).has_value = true := by rfl

theorem has_value_unexpected_proof (e : E) : (Expected.unexpected e : Expected E T).has_value = false := by rfl

theorem value_ok_proof [Inhabited T] (v : T) : (Expected.ok v : Expected E T).value = v := by rfl

theorem error_unexpected_proof [Inhabited E] (e : E) : (Expected.unexpected e : Expected E T).error = e := by rfl

theorem value_or_ok_proof (v : T) (d : T) : (Expected.ok v : Expected E T).value_or d = v := by rfl

theorem value_or_unexpected_proof (e : E) (d : T) : (Expected.unexpected e : Expected E T).value_or d = d := by rfl

theorem and_then_ok_proof (v : T) (f : T → Expected E U) :
    (Expected.ok v : Expected E T).and_then f = f v := by rfl

theorem and_then_unexpected_proof (e : E) (f : T → Expected E U) :
    (Expected.unexpected e : Expected E T).and_then f = Expected.unexpected e := by rfl

theorem transform_ok_proof (v : T) (f : T → U) :
    (Expected.ok v : Expected E T).transform f = Expected.ok (f v) := by rfl

theorem transform_unexpected_proof (e : E) (f : T → U) :
    (Expected.unexpected e : Expected E T).transform f = Expected.unexpected e := by rfl

theorem transform_error_ok_proof (v : T) (f : E → E2) :
    (Expected.ok v : Expected E T).transform_error f = Expected.ok v := by rfl

theorem transform_error_unexpected_proof (e : E) (f : E → E2) :
    (Expected.unexpected e : Expected E T).transform_error f = Expected.unexpected (f e) := by rfl

theorem or_else_ok_proof (v : T) (f : E → Expected E2 T) :
    (Expected.ok v : Expected E T).or_else f = Expected.ok v := by rfl

theorem or_else_unexpected_proof (e : E) (f : E → Expected E2 T) :
    (Expected.unexpected e : Expected E T).or_else f = f e := by rfl

theorem roundtrip_to_except_proof (x : Expected E T) :
    Expected.ofExcept x.toExcept = x := by
  cases x <;> rfl

theorem roundtrip_of_except_proof (x : Except E T) :
    (Expected.ofExcept x).toExcept = x := by
  cases x <;> rfl

theorem monad_pure_bind_proof (v : T) (f : T → Expected E U) :
    (pure v : Expected E T) >>= f = f v := by rfl

theorem monad_unexpected_bind_proof (e : E) (f : T → Expected E U) :
    (Expected.unexpected e : Expected E T) >>= f = Expected.unexpected e := by rfl

end Cpp.Expected
