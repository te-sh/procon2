# URL: https://yukicoder.me/problems/no/895

def solve(io)
  a, b, c = io.get3
  n = a + b + c

  ft = Fact(Mint).new(n)

  r = Mint.zero
  (c .. n - 2).each do |i|
    ri1 = ft.combi(n - 1 - c, b)
    ri1 -= ft.combi(i - c, b) if i - c >= b
    ri2 = ft.combi(i - 1, c - 1) * Mint.new(2) ** (i - 1)
    ri2 += ft.combi(i - 2, c - 2) * (Mint.new(2) ** (i - 1) - 1) if c >= 2
    r += ri1 * ri2
  end

  io.put r
end

require "lib/procon"

require "lib/math/fact"

require "lib/math/mod_int"
ModInt.new_type(Mint, 10**9+7)

solve(ProconIO.new)
