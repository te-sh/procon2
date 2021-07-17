# URL: https://atcoder.jp/contests/abc142/tasks/abc142_e

def solve(io)
  n, m = io.get2

  a = Array.new(m, 0)
  k = Array.new(m, 0)
  m.times do |i|
    ai, bi = io.get2
    a[i] = ai
    ci = io.get_a(bi); ci.map!(&.- 1)
    ci.each do |cij|
      k[i] = k[i] | (1 << cij)
    end
  end

  inf = 10**9
  dp = Array.new_md(m+1, 1 << n, inf)
  dp[0][0] = 0

  m.times do |i|
    (1 << n).times do |j|
      min_u(dp[i+1][j|k[i]], dp[i][j] + a[i])
      min_u(dp[i+1][j], dp[i][j])
    end
  end

  io.put dp[-1][-1] == inf ? -1 : dp[-1][-1]
end

require "lib/procon"

solve(ProconIO.new)
