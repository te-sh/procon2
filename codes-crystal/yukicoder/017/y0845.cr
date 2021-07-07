# URL: https://yukicoder.me/problems/no/845

def solve(io)
  n, m = io.get2

  g = Array.new_md(n, n, 0)
  m.times do
    ai, bi, ci = io.get3; ai -= 1; bi -= 1
    max_u(g[ai][bi], ci)
    max_u(g[bi][ai], ci)
  end

  dp = Array.new_md(1 << n, n, 0)
  (1 << n).times do |s|
    n.times do |i|
      next if s.popcount <= 1 || !s.bit?(i)
      n.times do |j|
        next if g[i][j] == 0 || !s.bit?(j)
        max_u(dp[s][i], dp[s.reset_bit(i)][j] + g[i][j])
      end
    end
  end
  io.put dp.map(&.max).max
end

require "lib/procon"

solve(ProconIO.new)
