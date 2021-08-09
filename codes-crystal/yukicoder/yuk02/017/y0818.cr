# URL: https://yukicoder.me/problems/no/818

def solve(io)
  n, m = io.get2(Int64)
  a, b = io.get2_c(n, Int64)

  dp = Array.new_md(n, 3, 0_i64)
  dp[0][0] = [m*a[0], (m-1)*a[0]+b[0], b[0]].max
  dp[0][1] = -(10_i64**18)
  dp[0][2] = -(10_i64**18)
  (1...n).each do |i|
    dp[i][0] = dp[i-1][0] + [m*a[i], (m-1)*a[i]+b[i], b[i]].max
    dp[i][1] = dp[i-1][0..1].max + [a[i], b[i]].max
    dp[i][2] = dp[i-1].max
  end

  io.put dp[n-1].max
end

require "lib/procon"

solve(ProconIO.new)
