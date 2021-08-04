# URL: https://atcoder.jp/contests/abc144/tasks/abc144_c

def solve(io)
  n = io.get(Int64)

  pf = PrimeFactor.sqrt(n)
  io.put pf.divisors(n).min_of { |d| (d - 1) + (n // d - 1) }
end

require "lib/procon"

require "lib/math/prime_factor"

solve(ProconIO.new)
