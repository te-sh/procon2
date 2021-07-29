# URL: https://yukicoder.me/problems/no/864

def solve(io)
  n, k = io.get2(Int64)

  pf = PrimeFactor.sqrt(k)

  r = 0_i64
  pf.divisors(k).each do |d|
    e = k // d
    m1 = d - 1 <= n ? d - 1 : (n * 2 - d + 1).clamp(0..)
    m2 = e - 1 <= n ? e - 1 : (n * 2 - e + 1).clamp(0..)
    r += m1 * m2
  end

  io.put r
end

require "lib/procon"

require "lib/math/prime_factor"

solve(ProconIO.new)
