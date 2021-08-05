# URL: https://atcoder.jp/contests/abc154/tasks/abc154_f

def solve(io)
  r1, c1, r2, c2 = io.get4
  f = Fact(Mint).new(r2 + c2 + 2)
  io.put func(r2 + 1, c2 + 1) - func(r2 + 1, c1) - func(r1, c2 + 1) + func(r1, c1)
end

macro func(x, y)
  f.combi({{x}} + {{y}}, {{x}})
end

require "lib/procon"

require "lib/math/fact"

require "lib/math/mod_int"
ModInt.new_type(Mint, 10**9+7)

solve(ProconIO.new)
