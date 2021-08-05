# URL: https://atcoder.jp/contests/abc153/tasks/abc153_b

def solve(io)
  h, n = io.get2
  a = io.get_a(n)
  io.put h - a.sum <= 0 ? "Yes" : "No"
end

require "lib/procon"

solve(ProconIO.new)
