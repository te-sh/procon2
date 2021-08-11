# URL: https://yukicoder.me/problems/no/888

def solve(io)
  n = io.get(Int64)
  pf = PrimeFactor.sqrt(n)
  io.put pf.divisors(n).sum
end

require "lib/procon"

require "lib/math/prime_factor"

solve(ProconIO.new)
