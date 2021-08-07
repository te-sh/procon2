# URL: https://yukicoder.me/problems/no/1636

def solve(io)
  n = io.get
  io.put (n - 1) * (n - 1)
end

require "lib/procon"

solve(ProconIO.new)
