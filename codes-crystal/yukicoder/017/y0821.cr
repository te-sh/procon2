# URL: https://yukicoder.me/problems/no/821

def solve(io)
  n, k = io.get2(Int64)
  io.put n*(n+1)//2 - (n-k)*(n-k+1)//2 + 1
end

require "lib/procon"

solve(ProconIO.new)
