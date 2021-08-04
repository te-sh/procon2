# URL: https://atcoder.jp/contests/abc150/tasks/abc150_e

def solve(io)
  n = io.get
  c = io.get_a(n)

  c.sort!

  r, m2 = Mint.new(0), Mint.new(2)
  c.each_with_index(1) do |ci, i|
    r += m2 ** (i - 1) * ci * (m2 ** (n - i) + m2 ** (n - i - 1) * (n - i))
  end

  io.put r * m2 ** n
end

require "lib/procon"

require "lib/math/mod_int"
ModInt.new_type(Mint, 10**9+7)

solve(ProconIO.new)
