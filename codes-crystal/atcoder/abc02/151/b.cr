# URL: https://atcoder.jp/contests/abc151/tasks/abc151_b

def solve(io)
  n, k, m = io.get3
  a = io.get_a(n - 1)

  r = n * m - a.sum
  io.put r <= k ? r.clamp(0..) : -1
end

require "lib/procon"

solve(ProconIO.new)
