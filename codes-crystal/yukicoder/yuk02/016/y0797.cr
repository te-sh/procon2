# URL: https://yukicoder.me/problems/no/797

def solve(io)
  n = io.get
  a = io.get_a(n)

  f = Fact(Mint).new(n)
  r = Mint.zero
  a.each_with_index do |ai, i|
    r += f.combi(n-1, i) * ai
  end

  io.put r
end

require "lib/procon"

require "lib/math/fact"

require "lib/math/mod_int"
ModInt.new_type(Mint, 10**9+7)

solve(ProconIO.new)
