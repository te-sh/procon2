# URL: https://atcoder.jp/contests/abc144/tasks/abc144_a

def solve(io)
  a, b = io.get2
  io.put a <= 9 && b <= 9 ? a * b : -1
end

require "lib/procon"

solve(ProconIO.new)
