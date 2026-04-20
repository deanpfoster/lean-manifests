# Coverage: std::optional (§22.5)

Source: N4950 §22.5.1–22.5.10 (pages 705–724)
Total spec claims: 180
- BEHAVIORAL: 89 (theorem candidates)
- C++_ONLY: 36 (exception safety, triviality, constexpr — skip)
- CONSTRAINT: 55 (type constraints — maps to typeclass, not theorem)

## Coverage scoring

- PROVEN: has a ProvenTheorem in the header
- TESTED: has a TestedConjecture in the header  
- STATED: has an UnprovenConjecture (sorry, no test)
- MISSING: no theorem at all — gap to fill
- SKIP: C++_ONLY or CONSTRAINT, not applicable in Lean

## §22.5.3.2 Constructors

| § | Category | Claim | Status | Theorem |
|---|----------|-------|--------|---------|
| /2 | BEHAVIORAL | default/nullopt: does not contain a value | PROVEN | `has_value_nullopt` |
| /3 | C++_ONLY | constexpr | SKIP | |
| /4 | BEHAVIORAL | copy: initializes with *rhs | SKIP | no mutation model |
| /5 | BEHAVIORAL | copy: postcondition has_value preserved | SKIP | no mutation model |
| /6 | C++_ONLY | throws | SKIP | |
| /7 | C++_ONLY | deleted/trivial | SKIP | |
| /8 | CONSTRAINT | move: is_move_constructible | SKIP | |
| /9 | BEHAVIORAL | move: initializes with move(*rhs) | SKIP | no mutation model |
| /10 | BEHAVIORAL | move: postcondition has_value preserved | SKIP | no mutation model |
| /11 | C++_ONLY | throws | SKIP | |
| /12 | C++_ONLY | noexcept/trivial | SKIP | |
| /13 | CONSTRAINT | in_place: is_constructible | SKIP | |
| /14 | BEHAVIORAL | in_place: initializes contained value | PROVEN | `has_value_some` (via `some` constructor) |
| /15 | BEHAVIORAL | in_place: postcondition has value | PROVEN | `has_value_some` |
| /16–17 | C++_ONLY | throws/constexpr | SKIP | |
| /18 | CONSTRAINT | initializer_list | SKIP | |
| /19–22 | BEHAVIORAL+C++_ONLY | initializer_list constructor | SKIP | no initializer_list |
| /23 | CONSTRAINT | converting U&&: is_constructible | SKIP | |
| /24 | BEHAVIORAL | converting U&&: initializes with forward(v) | MISSING | could model as `Optional.some` |
| /25 | BEHAVIORAL | converting U&&: postcondition has value | PROVEN | `has_value_some` |
| /26–27 | C++_ONLY | throws/explicit | SKIP | |
| /28–32 | CONSTRAINT+BEHAVIORAL+C++_ONLY | converting optional<U>& | SKIP | no cross-type optional |
| /33–37 | CONSTRAINT+BEHAVIORAL+C++_ONLY | converting optional<U>&& | SKIP | no cross-type optional |

## §22.5.3.3 Destructor

| § | Category | Claim | Status | Theorem |
|---|----------|-------|--------|---------|
| /1 | BEHAVIORAL | destructor calls ~T() if has value | SKIP | no destructor model |
| /2 | C++_ONLY | trivial destructor | SKIP | |

## §22.5.3.4 Assignment

| § | Category | Claim | Status | Theorem |
|---|----------|-------|--------|---------|
| /1 | BEHAVIORAL | assign nullopt: destroys if has value | PROVEN | `reset_has_value` (reset models nullopt assign) |
| /2 | BEHAVIORAL | assign nullopt: postcondition no value | PROVEN | `reset_has_value` |
| /3 | BEHAVIORAL | assign nullopt: returns *this | SKIP | no *this in pure |
| /4 | BEHAVIORAL | copy assign: 4-case table | SKIP | no mutation model |
| /5 | BEHAVIORAL | copy assign: postcondition has_value preserved | SKIP | no mutation model |
| /6 | BEHAVIORAL | copy assign: returns *this | SKIP | |
| /7 | C++_ONLY | exception safety / deleted / trivial | SKIP | |
| /8–13 | CONSTRAINT+BEHAVIORAL+C++_ONLY | move assign | SKIP | no mutation model |
| /14–18 | CONSTRAINT+BEHAVIORAL+C++_ONLY | converting assign U&& | SKIP | |
| /19–23 | CONSTRAINT+BEHAVIORAL+C++_ONLY | converting assign optional<U>& | SKIP | |
| /24–28 | CONSTRAINT+BEHAVIORAL+C++_ONLY | converting assign optional<U>&& | SKIP | |
| /29 | CONSTRAINT | emplace mandates | SKIP | |
| /30 | BEHAVIORAL | emplace: nullopt then initialize | PROVEN | `emplace_has_value` |
| /31 | BEHAVIORAL | emplace: postcondition has value | PROVEN | `emplace_has_value` |
| /32 | BEHAVIORAL | emplace: returns reference | SKIP | |
| /33–34 | C++_ONLY | emplace throws/exception safety | SKIP | |
| /35–40 | CONSTRAINT+BEHAVIORAL+C++_ONLY | emplace with initializer_list | SKIP | |

## §22.5.3.5 Swap

| § | Category | Claim | Status | Theorem |
|---|----------|-------|--------|---------|
| /1 | CONSTRAINT | is_move_constructible | SKIP | |
| /2 | BEHAVIORAL | precondition Swappable | SKIP | |
| /3 | BEHAVIORAL | 4-case swap table | MISSING | could model swap as function |
| /4–6 | C++_ONLY | throws/noexcept/exception safety | SKIP | |

## §22.5.3.6 Observers

| § | Category | Claim | Status | Theorem |
|---|----------|-------|--------|---------|
| /1–2 | BEHAVIORAL | operator-> returns val | SKIP | no pointer model |
| /3 | C++_ONLY | constexpr | SKIP | |
| /4–5 | BEHAVIORAL | operator* returns *val | PROVEN | `value_some` |
| /6 | C++_ONLY | constexpr | SKIP | |
| /7–8 | BEHAVIORAL | operator* && returns move(*val) | SKIP | no rvalue |
| /9 | BEHAVIORAL | bool conversion: true iff has value | PROVEN | `has_value_some` + `has_value_nullopt` |
| /10 | C++_ONLY | constexpr | SKIP | |
| /11 | BEHAVIORAL | has_value(): true iff contains value | PROVEN | `has_value_some` + `has_value_nullopt` |
| /12 | C++_ONLY | constexpr | SKIP | |
| /13 | BEHAVIORAL | value(): return val or throw | PROVEN | `value_some` (+ panic for nullopt) |
| /14 | BEHAVIORAL | value() &&: move or throw | SKIP | no rvalue |
| /15 | CONSTRAINT | value_or mandates | SKIP | |
| /16 | BEHAVIORAL | value_or: has_value ? **this : forward(v) | PROVEN | `value_or_some` + `value_or_nullopt` |
| /17 | CONSTRAINT | value_or && mandates | SKIP | |
| /18 | BEHAVIORAL | value_or &&: has_value ? move(**this) : forward(v) | SKIP | no rvalue |

## §22.5.3.7 Monadic operations

| § | Category | Claim | Status | Theorem |
|---|----------|-------|--------|---------|
| /1–2 | CONSTRAINT | and_then return type must be optional | SKIP | enforced by Lean types |
| /3 | BEHAVIORAL | and_then &: has value → invoke(f, value()), else empty | PROVEN | `and_then_some` + `and_then_nullopt` |
| /4–5 | CONSTRAINT | and_then && return type | SKIP | |
| /6 | BEHAVIORAL | and_then &&: has value → invoke(f, move(value())), else empty | SKIP | no rvalue |
| /7–8 | CONSTRAINT | transform return type | SKIP | |
| /9 | BEHAVIORAL | transform &: has value → optional(f(value())), else empty | PROVEN | `transform_some` + `transform_nullopt` |
| /10–11 | CONSTRAINT | transform && return type | SKIP | |
| /12 | BEHAVIORAL | transform &&: has value → optional(f(move(value()))), else empty | SKIP | no rvalue |
| /13–14 | CONSTRAINT | or_else constraints | SKIP | |
| /15 | BEHAVIORAL | or_else const&: has value → *this, else f() | PROVEN | `or_else_some` + `or_else_nullopt` |
| /16–17 | CONSTRAINT | or_else && constraints | SKIP | |
| /18 | BEHAVIORAL | or_else &&: has value → move(*this), else f() | SKIP | no rvalue |

## §22.5.3.8 Modifiers

| § | Category | Claim | Status | Theorem |
|---|----------|-------|--------|---------|
| /1 | BEHAVIORAL | reset: destroys if has value, else no effect | PROVEN | `reset_has_value` |
| /2 | BEHAVIORAL | reset: postcondition no value | PROVEN | `reset_has_value` |

## §22.5.6 Relational operators (optional vs optional)

| § | Category | Claim | Status | Theorem |
|---|----------|-------|--------|---------|
| /1 | CONSTRAINT | == mandates | SKIP | |
| /2 | BEHAVIORAL | ==: both empty→true, diff has_value→false, both have→*x==*y | MISSING | have BEq instance but no theorem |
| /3 | C++_ONLY | constexpr | SKIP | |
| /4 | CONSTRAINT | != mandates | SKIP | |
| /5 | BEHAVIORAL | !=: both empty→false, diff→true, both have→*x!=*y | MISSING | |
| /6 | C++_ONLY | constexpr | SKIP | |
| /7–18 | CONSTRAINT+BEHAVIORAL+C++_ONLY | <, >, <=, >= | MISSING | have Ord instance but no theorems |
| /19 | BEHAVIORAL | <=>: both have → *x<=>*y, else has_value<=>has_value | MISSING | |
| /20 | C++_ONLY | constexpr | SKIP | |

## §22.5.7 Comparison with nullopt

| § | Category | Claim | Status | Theorem |
|---|----------|-------|--------|---------|
| /1 | BEHAVIORAL | ==(optional, nullopt): returns !has_value() | MISSING | |
| /2 | BEHAVIORAL | <=>(optional, nullopt) | MISSING | |

## §22.5.8 Comparison with T

| § | Category | Claim | Status | Theorem |
|---|----------|-------|--------|---------|
| /1–2 | CONSTRAINT+BEHAVIORAL | ==(optional, U): has_value ? *x==v : false | MISSING | |
| /3–4 | CONSTRAINT+BEHAVIORAL | ==(T, optional): has_value ? v==*x : false | MISSING | |
| /5–25 | CONSTRAINT+BEHAVIORAL+C++_ONLY | all other comparison operators with T | MISSING | |

## §22.5.9 Specialized algorithms

| § | Category | Claim | Status | Theorem |
|---|----------|-------|--------|---------|
| /1 | CONSTRAINT | swap constraints | SKIP | |
| /2 | BEHAVIORAL | swap calls x.swap(y) | MISSING | |
| /3 | BEHAVIORAL | make_optional returns optional(forward(v)) | MISSING | |
| /4–5 | BEHAVIORAL | make_optional with args / initializer_list | MISSING | |

## §22.5.10 Hash support

| § | Category | Claim | Status | Theorem |
|---|----------|-------|--------|---------|
| /1 | BEHAVIORAL | hash consistency with contained value | MISSING | |

## Summary

| Status | Count | % of BEHAVIORAL |
|--------|-------|-----------------|
| PROVEN | 17 | 19% |
| TESTED (monad/functor laws) | 6 | 7% |
| MISSING (expressible in Lean) | ~18 | 20% |
| SKIP (C++_ONLY / CONSTRAINT / no model) | ~48 | 54% |
| **Total BEHAVIORAL** | **89** | **100%** |

**Coverage of expressible claims: 23 of ~41 (56%)**

The 18 MISSING expressible claims are mostly comparison operators (§22.5.6–8)
and make_optional/swap. These are straightforward to add — they don't need
new modeling, just new theorems about the existing BEq and Ord instances.
