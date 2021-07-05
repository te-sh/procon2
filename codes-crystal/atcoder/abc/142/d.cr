# URL: https://atcoder.jp/contests/abc142/tasks/abc142_d

def main(io)
  a, b = io.get2(Int64)
  g = a.gcd(b)

  pf = PrimeFactor.sqrt(g)
  io.put pf.div(g).size + 1
end

require "lib/math/prime_factor"

require "lib/procon_io"

main(ProconIO.new)
