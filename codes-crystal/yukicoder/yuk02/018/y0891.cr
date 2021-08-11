# URL: https://yukicoder.me/problems/no/891

def solve(io)
  a, b, n = io.get3
  m = Matrix.new(Mint.array([[a, b], [1, 0]]))
  r = m ** n * Vector.new(Mint.array([1, 0]))
  io.put r[1]
end

require "lib/procon"

require "lib/math/matrix"

require "lib/math/mod_int"
ModInt.new_type(Mint, 10**9+7)

solve(ProconIO.new)
