# URL: https://atcoder.jp/contests/abc153/tasks/abc153_c

def solve(io)
  n, k = io.get2
  h = io.get_a(n, Int64)
  h.sort! { |a, b| b <=> a }
  io.put k >= n ? 0 : h[k..].sum
end

require "lib/procon"

solve(ProconIO.new)
