# URL: https://atcoder.jp/contests/abc152/tasks/abc152_e

def solve(io)
  n = io.get
  a = io.get_a(n)
  ma = a.max

  pf = PrimeFactor.sqrt(ma)
  d = Array.new(ma + 1, 0)
  a.each do |ai|
    pf.div(ai).each do |f|
      max_u(d[f.prime], f.exp)
    end
  end

  l = Mint.new(1)
  (2..ma).each do |i|
    l *= Mint.new(i) ** d[i]
  end

  io.put a.map { |ai| l // Mint.new(ai) }.sum
end

require "lib/procon"

require "lib/math/prime_factor"

require "lib/math/mod_int"
ModInt.new_type(Mint, 10**9+7)

solve(ProconIO.new)
