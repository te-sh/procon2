# URL: https://atcoder.jp/contests/abc135/tasks/abc135_a

def solve(io)
  a, b = io.get2
  io.put (a + b).even? ? (a + b) // 2 : "IMPOSSIBLE"
end

require "lib/procon"

solve(ProconIO.new)
