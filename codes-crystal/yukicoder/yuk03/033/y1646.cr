# URL: https://yukicoder.me/problems/no/1646

def solve(io)
  n = io.get
  s = io.get(String)

  if n == 1
    io.put_e s[0] == '?' ? 26 : 1
  end

  dp = Array.new_md(n + 1, 26, 26, Mint.new(0))
  (0...26).each do |j|
    (0...26).each do |k|
      if (s[0] == '?' || s[0] - 'a' == j) && (s[1] == '?' || s[1] - 'a' == k) && j != k
        dp[2][j][k] = Mint.new(1)
      end
    end
  end

  (2...n).each do |i|
    c = (0...26).map { |k| (0...26).map { |l| dp[i][l][k] }.sum }
    (0...26).each do |j|
      next unless s[i] == '?' || s[i] - 'a' == j
      (0...26).each do |k|
        next if j == k
        dp[i + 1][k][j] += c[k] - dp[i][j][k]
      end
    end
  end

  io.put dp[n].map(&.sum).sum
end

require "lib/procon"

require "lib/math/mod_int"
ModInt.new_type(Mint, 998244353)

solve(ProconIO.new)
