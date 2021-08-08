# URL: https://atcoder.jp/contests/abc156/tasks/abc156_e

def solve(io)
  n, k = io.get2

  f = Fact(Mint).new(n)
  r = Mint.zero
  ((k == 1 ? 1 : 0) .. {k, n - 1}.min).each do |i|
    r += f.combi(n, i) * f.combi(n - 1, i)
  end

  io.put r
end

require "lib/procon"

require "lib/math/fact"

require "lib/math/mod_int"
ModInt.new_type(Mint, 10**9+7)

solve(ProconIO.new)
