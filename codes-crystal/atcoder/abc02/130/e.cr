# URL: https://atcoder.jp/contests/abc130/tasks/abc130_e

def solve(io)
  n, m = io.get2
  s = io.get_a(n)
  t = io.get_a(m)

  dp = Array.new_md(n + 1, m + 1, Mint.zero)
  dps = Array.new_md(n + 1, m + 1, Mint.zero)
  dp[0][0] = Mint.new(1)
  (n + 1).times do |i|
    dps[i][0] = Mint.new(1)
  end
  (m + 1).times do |j|
    dps[0][j] = Mint.new(1)
  end

  s.each_with_index(1) do |si, i|
    t.each_with_index(1) do |ti, j|
      dp[i][j] = dps[i - 1][j - 1] if si == ti
      dps[i][j] = dps[i - 1][j] + dps[i][j - 1] - dps[i - 1][j - 1] + dp[i][j]
    end
  end

  io.put dps[n][m]
end

require "lib/procon"

require "lib/math/mod_int"
ModInt.new_type(Mint, 10**9+7)

solve(ProconIO.new)
