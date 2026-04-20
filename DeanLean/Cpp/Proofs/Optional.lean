import DeanLean.Cpp.Code.Optional

namespace Cpp.Optional

variable {T U : Type}

theorem has_value_some_proof (v : T) : (Optional.some v).has_value = true := by rfl

theorem has_value_nullopt_proof : (Optional.nullopt : Optional T).has_value = false := by rfl

theorem value_some_proof [Inhabited T] (v : T) : (Optional.some v).value = v := by rfl

theorem value_or_some_proof (v d : T) : (Optional.some v).value_or d = v := by rfl

theorem value_or_nullopt_proof (d : T) : (Optional.nullopt).value_or d = d := by rfl

theorem emplace_has_value_proof (o : Optional T) (v : T) :
    (o.emplace v).has_value = true := by rfl

theorem reset_has_value_proof (o : Optional T) :
    o.reset.has_value = false := by rfl

theorem and_then_some_proof (v : T) (f : T → Optional U) :
    (Optional.some v).and_then f = f v := by rfl

theorem and_then_nullopt_proof (f : T → Optional U) :
    (Optional.nullopt).and_then f = Optional.nullopt := by rfl

theorem transform_some_proof (v : T) (f : T → U) :
    (Optional.some v).transform f = Optional.some (f v) := by rfl

theorem transform_nullopt_proof (f : T → U) :
    (Optional.nullopt : Optional T).transform f = Optional.nullopt := by rfl

theorem or_else_some_proof (v : T) (f : Unit → Optional T) :
    (Optional.some v).or_else f = Optional.some v := by rfl

theorem or_else_nullopt_proof (f : Unit → Optional T) :
    (Optional.nullopt).or_else f = f () := by rfl

theorem roundtrip_to_option_proof (o : Optional T) :
    Optional.ofOption o.toOption = o := by
  cases o <;> rfl

theorem roundtrip_of_option_proof (o : Option T) :
    (Optional.ofOption o).toOption = o := by
  cases o <;> rfl

theorem monad_pure_and_then_proof (v : T) (f : T → Optional U) :
    (pure v : Optional T) >>= f = f v := by rfl

theorem monad_nullopt_bind_proof (f : T → Optional U) :
    (Optional.nullopt : Optional T) >>= f = Optional.nullopt := by rfl

end Cpp.Optional
