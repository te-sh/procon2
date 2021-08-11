# URL: https://yukicoder.me/problems/no/892

def solve(io)
  a1, b1, a2, b2, a3, b3 = io.get6(Int64)
  io.put (a1 + a2 + a3).even? ? ":-)" : ":-("
end

require "lib/procon"

solve(ProconIO.new)
