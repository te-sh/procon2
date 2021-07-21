# URL: https://yukicoder.me/problems/no/793

def solve(io)
  n = io.get(Int64)
  io.put Mint.new(10) ** n + (Mint.new(10) ** n - 1) // 3
end

require "lib/procon"

require "lib/math/mod_int"
ModInt.new_type(Mint, 10**9+7)

solve(ProconIO.new)
