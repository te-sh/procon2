# URL: https://atcoder.jp/contests/abc145/tasks/abc145_d

def solve(io)
  x, y = io.get2

  u, v = y * 2 - x, x * 2 - y
  io.put_e 0 if u % 3 != 0 || v % 3 != 0 || u < 0 || v < 0
  u //= 3
  v //= 3

  f = Fact(Mint).new(u + v)
  io.put f.combi(u + v, u)
end

require "lib/procon"

require "lib/math/fact"

require "lib/math/mod_int"
ModInt.new_type(Mint, 10**9+7)

solve(ProconIO.new)
