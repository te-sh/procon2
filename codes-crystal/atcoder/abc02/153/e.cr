# URL: https://atcoder.jp/contests/abc153/tasks/abc153_e

def solve(io)
  h, n = io.get2
  a, b = io.get2_c(n)

  dp = Array.new(h + 1, 10**9)
  (1..h).each do |i|
    (0...n).each do |j|
      min_u(dp[i], (i > a[j] ? dp[i - a[j]] : 0) + b[j])
    end
  end

  io.put dp[h]
end

require "lib/procon"

solve(ProconIO.new)
