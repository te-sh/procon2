# URL: https://yukicoder.me/problems/no/780

def solve(io)
  a, b = io.get2
  if a < b
    io.put "YES"
    io.put b - a - 1
  else
    io.put "NO"
    io.put a - b + 1
  end
end

require "lib/procon"

solve(ProconIO.new)
