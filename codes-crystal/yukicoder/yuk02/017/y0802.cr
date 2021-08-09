# URL: https://yukicoder.me/problems/no/802

def solve(io)
  n, m, d1, d2 = io.get4(Int64)

  d = d2-d1
  m = m-(n-1)*d1-1
  io.put_e 0 if m < 0

  f = Fact(Mint).new((n+m).to_i32)
  r = f.homo(n+1, m)
  (1..n-1).each do |i|
    next if m-(d+1)*i < 0
    r -= f.combi(n-1, i) * f.homo(n+1, m-i*(d+1)) * (-1)**(i-1)
  end

  io.put r
end

require "lib/procon"

require "lib/math/fact"

require "lib/math/mod_int"
ModInt.new_type(Mint, 10**9+7)

solve(ProconIO.new)
