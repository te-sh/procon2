# URL: https://yukicoder.me/problems/no/820

def solve(io)
  n, k = io.get2
  io.put n >= k ? 2**(n-k) : 0
end

require "lib/procon"

solve(ProconIO.new)
