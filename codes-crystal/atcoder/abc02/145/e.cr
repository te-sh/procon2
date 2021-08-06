# URL: https://atcoder.jp/contests/abc145/tasks/abc145_e

def solve(io)
  n, t = io.get2
  a, b = io.get2_c(n)
  f = zip(a, b).map { |ai, bi| Food.new(ai, bi) }
  f.sort_by!(&.a)

  m = t + f[-1].a
  dp = Array.new_md(n + 1, m, 0)
  n.times do |i|
    m.times do |j|
      max_u(dp[i + 1][j], dp[i][j])
      if j - f[i].a >= 0 && j - f[i].a < t
        max_u(dp[i + 1][j], dp[i][j - f[i].a] + f[i].b)
      end
    end
  end

  io.put dp[n].max
end

record Food, a : Int32, b : Int32

require "lib/procon"

solve(ProconIO.new)
