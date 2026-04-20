import DeanLean.Cpp.Code.Concepts

namespace Cpp.Concepts

variable {T U : Type}

-- ============================================================================
-- §18.4.2 same_as is symmetric (Prop-valued, so can be a theorem)
-- ============================================================================

theorem same_as_symmetric_proof (h : same_as T U) : same_as U T :=
  h.symm

theorem same_as_refl_proof : same_as T T :=
  rfl

-- ============================================================================
-- §18.4.7 signed_integral → integral (data, so use def)
-- ============================================================================

def signed_integral_implies_integral_proof [SignedIntegral T] :
    Integral T :=
  inferInstance

-- ============================================================================
-- §18.4.7 unsigned_integral → integral
-- ============================================================================

def unsigned_integral_implies_integral_proof [UnsignedIntegral T] :
    Integral T :=
  inferInstance

-- ============================================================================
-- §18.6 regular → semiregular
-- ============================================================================

def regular_implies_semiregular_proof [Regular T] :
    Semiregular T :=
  inferInstance

-- ============================================================================
-- §18.6 regular → equality_comparable
-- ============================================================================

def regular_implies_equality_comparable_proof [Regular T] :
    EqualityComparable T :=
  inferInstance

-- ============================================================================
-- §18.6 regular → copy_constructible
-- ============================================================================

def regular_implies_copy_constructible_proof [Regular T] :
    CopyConstructible T :=
  inferInstance

-- ============================================================================
-- §18.6 semiregular → copy_constructible
-- ============================================================================

def semiregular_implies_copy_constructible_proof [Semiregular T] :
    CopyConstructible T :=
  inferInstance

-- ============================================================================
-- §18.6 semiregular → default_initializable
-- ============================================================================

def semiregular_implies_default_initializable_proof [Semiregular T] :
    DefaultInitializable T :=
  inferInstance

-- ============================================================================
-- §18.4.14 copy_constructible → move_constructible
-- ============================================================================

def copy_constructible_implies_move_constructible_proof [CopyConstructible T] :
    MoveConstructible T :=
  inferInstance

-- ============================================================================
-- §18.5.5 totally_ordered → equality_comparable
-- ============================================================================

def totally_ordered_implies_equality_comparable_proof [TotallyOrdered T] :
    EqualityComparable T :=
  inferInstance

-- ============================================================================
-- §18.4.3 derived_from → convertible_to
-- ============================================================================

def derived_from_implies_convertible_to_proof [DerivedFrom T U] :
    ConvertibleTo T U :=
  inferInstance

-- ============================================================================
-- §18.7 regular_invocable → invocable
-- ============================================================================

variable {F : Type}

def regular_invocable_implies_invocable_proof [RegularInvocable F T U] :
    Invocable F T U :=
  inferInstance

-- ============================================================================
-- Built-in type instances
-- ============================================================================

def nat_is_unsigned_integral_proof : UnsignedIntegral Nat :=
  inferInstance

def nat_is_integral_proof : Integral Nat :=
  inferInstance

def int_is_signed_integral_proof : SignedIntegral Int :=
  inferInstance

def int_is_integral_proof : Integral Int :=
  inferInstance

def float_is_floating_point_proof : FloatingPoint Float :=
  inferInstance

def nat_convertible_to_int_proof : ConvertibleTo Nat Int :=
  inferInstance

end Cpp.Concepts
