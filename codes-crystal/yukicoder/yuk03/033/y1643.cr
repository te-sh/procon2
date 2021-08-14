# URL: https://yukicoder.me/problems/no/1643

def solve(io)
  s = io.get(String)
  io.put "a" * (s.count('a') + 1)
end

require "lib/procon"

solve(ProconIO.new)
