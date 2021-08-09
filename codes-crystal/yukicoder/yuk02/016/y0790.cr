# URL: https://yukicoder.me/problems/no/790

def solve(io)
  n = io.get

  dp = Array.new_md(n*2+1, n+1, 0)
  dp[0][0] = 1

  (0...n*2).each do |i|
    (0..n).each do |j|
      dp[i+1][j] += dp[i][j-1] if j >= 1
      dp[i+1][j] += dp[i][j+1] if j <= n-1
    end
  end

  io.put dp[n*2][0]
end

require "lib/procon"

solve(ProconIO.new)
