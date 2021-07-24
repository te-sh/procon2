# URL: https://yukicoder.me/problems/no/863

def solve(io)
  a = io.get(Int64)
  b = io.get(Int64)
  io.put a/5000 < (b+1)/200000 && b/200000 < (a+1)/5000 ? 1 : 2
end

require "lib/procon"

solve(ProconIO.new)
