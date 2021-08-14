# URL: https://yukicoder.me/problems/no/1645

def solve(io)
  n = io.get
  a = io.get_a(n)
  s = a.sum

  dp = Array.new_md(n + 1, 10001, Mint.zero)
  dp[0][0] = Mint.new(1)
  n.times do |i|
    (0..10000).each do |j|
      dp[i + 1][j] = dp[i][j]
      dp[i + 1][j] += dp[i][j - a[i]] if j >= a[i]
    end
  end

  r = Mint.zero
  (0..10000).each do |j|
    r += Mint.new((s - j * 2).abs) * dp[n][j]
  end

  io.put r
end

require "lib/procon"

require "lib/math/mod_int"
ModInt.new_type(Mint, 998244353)

solve(ProconIO.new)
