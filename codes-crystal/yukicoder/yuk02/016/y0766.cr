# URL: https://yukicoder.me/problems/no/766

def solve(io)
  n, m, p = io.get3
  v = io.get_a(n)

  v.sort! { |a, b| b <=> a }

  w = Array.new(n) { |i| Mint.new(v[i]) }
  wc = CumulativeSum.new(w)

  pp = Array.new(m+1, Mint.zero)
  pp[0] = Mint.new(1)
  (1..m).each do |i|
    pp[i] = pp[i-1] * p // 100
  end

  p1p = Array.new(n+1, Mint.zero)
  p1p[0] = Mint.new(1)
  (1..n).each do |i|
    p1p[i] = p1p[i-1] * (100-p) // 100
  end

  f = Fact(Mint).new(n+m)

  r = Mint.zero
  m.times do |i|
    r += wc[0...n] * f.combi(n-1+i, i) * p1p[n] * pp[i]
  end
  n.times do |i|
    r += wc[0...i] * f.combi(m-1+i, i) * p1p[i] * pp[m]
  end

  io.put r
end

require "lib/procon"

require "lib/data_structure/cumulative_sum"

require "lib/math/fact"

require "lib/math/mod_int"
ModInt.new_type(Mint, 10**9+7)

solve(ProconIO.new)
