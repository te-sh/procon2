# URL: https://atcoder.jp/contests/abc151/tasks/abc151_e

def solve(io)
  n, k = io.get2
  a = io.get_a(n)
  a.sort!

  f = Fact(Mint).new(n)

  mi = Mint.zero
  a.each_with_index(1) do |ai, i|
    mi += f.combi(n - i, k - 1) * ai if n - i >= k - 1
  end

  a.reverse!
  ma = Mint.zero
  a.each_with_index(1) do |ai, i|
    ma += f.combi(n - i, k - 1) * ai if n - i >= k - 1
  end

  io.put ma - mi
end

require "lib/procon"

require "lib/math/fact"

require "lib/math/mod_int"
ModInt.new_type(Mint, 10**9+7)

solve(ProconIO.new)
