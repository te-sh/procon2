# URL: https://yukicoder.me/problems/no/786

def solve(io)
  n = io.get

  dp = Array.new(n+1, 0_i64)
  dp[0], dp[1] = 1_i64, 1_i64
  (2..n).each do |i|
    dp[i] = dp[i-1] + dp[i-2]
  end

  io.put dp[n]
end

require "lib/procon"

solve(ProconIO.new)
