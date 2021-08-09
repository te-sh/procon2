# URL: https://yukicoder.me/problems/no/846

def solve(io)
  p, q, r = io.get3(Int64)
  a, b, c = io.get3(Int64)

  a, b, c = a, a+b, a+b+c
  na1, na2 = (a-1)*p+1, a*p
  nb1, nb2 = (b-1)*q+1, b*q
  nc1, nc2 = (c-1)*r+1, c*r

  n1 = [na1, nb1, nc1].max
  n2 = [na2, nb2, nc2].min
  io.put n1 <= n2 ? [n1, n2] : -1
end

require "lib/procon"

solve(ProconIO.new)
