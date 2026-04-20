import DeanLean.Cpp.Code.Pair

namespace Cpp.Pair.Tests

#eval do
  let p := Cpp.make_pair 1 "hello"
  assert! p.first == 1
  assert! p.second == "hello"
  assert! p.swap.first == "hello"
  assert! p.swap.second == 1
  assert! p.swap.swap == p
  assert! p.tuple_size == 2

#eval do
  let p := Cpp.make_pair 1 2
  let q := Cpp.make_pair 1 2
  let r := Cpp.make_pair 1 3
  assert! p == q
  assert! !(p == r)

#eval do
  let p := Cpp.make_pair 1 2
  assert! (p.map_first (· + 10)) == Cpp.make_pair 11 2
  assert! (p.map_second (· * 3)) == Cpp.make_pair 1 6

end Cpp.Pair.Tests
