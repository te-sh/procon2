# URL: https://yukicoder.me/problems/no/890

def solve(io)
  n, k = io.get2
  g = n.gcd(k)
  pf = PrimeFactor.sqrt(g)
  ft = Fact(Mint).new(n)

  a = Hash(Int32, Mint).new(Mint.zero)
  pf.divisors(g).reverse_each do |di|
    next if di == 1
    i = n // di
    a[i] = ft.combi(i, k // di)
    pf.divisors(i).each do |ei|
      next if ei == i
      a[i] -= a[ei]
    end
  end

  io.put a.values.sum
end

require "lib/procon"

require "lib/math/prime_factor"

require "lib/math/fact"

require "lib/math/mod_int"
ModInt.new_type(Mint, 10**9+7)

solve(ProconIO.new)
