# URL: https://atcoder.jp/contests/abc133/tasks/abc133_a

def solve(io)
  n, a, b = io.get3
  io.put Math.min(n*a, b)
end

require "lib/procon"

solve(ProconIO.new)
