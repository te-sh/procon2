# URL: https://atcoder.jp/contests/abc136/tasks/abc136_e

def solve(io)
  n, k = io.get2
  a = io.get_a(n)

  s = a.sum

  pf = PrimeFactor.sqrt(s)
  m = 1
  pf.divisors(s).each do |d|
    b = a.map(&.% d).sort
    max_u(m, d) if b[0 ... -b.sum // d].sum <= k
  end

  io.put m
end

require "lib/procon"

require "lib/math/prime_factor"

solve(ProconIO.new)
