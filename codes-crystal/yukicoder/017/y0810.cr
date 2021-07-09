# URL: https://yukicoder.me/problems/no/810

def solve(io)
  l, r, m = io.get3
  io.put Math.min(m, r-l+1)
end

require "lib/procon"

solve(ProconIO.new)
