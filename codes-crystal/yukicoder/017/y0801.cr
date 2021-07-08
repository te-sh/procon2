# URL: https://yukicoder.me/problems/no/801

def solve(io)
  n, m, k = io.get3
  l, r = io.get2_c(m); l.map!(&.- 1); r.map!(&.- 1)

  dp = Array.new_md(k+1, n+1, Mint.zero)
  dp[0][0] = Mint.new(1)

  k.times do |ki|
    dpc = CumulativeSum.new(dp[ki])
    m.times do |mi|
      dp[ki+1][l[mi]] += dpc[l[mi]..r[mi]]
      dp[ki+1][r[mi]+1] -= dpc[l[mi]..r[mi]]
    end
    n.times do |ni|
      dp[ki+1][ni+1] += dp[ki+1][ni]
    end
  end

  io.put dp[k][n-1]
end

require "lib/procon"

require "lib/data_structure/cumulative_sum"

require "lib/math/mod_int"
ModInt.new_type(Mint, 10**9+7)

solve(ProconIO.new)
