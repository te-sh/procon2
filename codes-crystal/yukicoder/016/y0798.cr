# URL: https://yukicoder.me/problems/no/798

def solve(io)
  n = io.get
  a, b = io.get2_c(n)
  m = Array.new(n) { |i| M.new(a[i], b[i]) }
  m.sort! { |a, b| b.b <=> a.b }

  dp = Array.new_md(n+1, n//3+1, 10_i64**18)
  dp[0][0] = 0

  (0...n).each do |i|
    (0..n//3).each do |j|
      if i - j >= 0
        min_u(dp[i+1][j], dp[i][j] + m[i].a + (i-j) * m[i].b)
      end
      if j >= 1
        min_u(dp[i+1][j], dp[i][j-1])
      end
    end
  end

  io.put dp[-1][-1]
end

record M, a : Int32, b : Int32

require "lib/procon"

solve(ProconIO.new)
