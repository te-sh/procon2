# URL: https://yukicoder.me/problems/no/882

def solve(io)
  a, b = io.get2
  io.put a % b == 0 ? "YES" : "NO"
end

require "lib/procon"

solve(ProconIO.new)
