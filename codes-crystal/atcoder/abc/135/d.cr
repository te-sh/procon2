# URL: https://atcoder.jp/contests/abc135/tasks/abc135_d

def solve(io)
  s = io.get(String)
  t = s.chars.map { |c| c == '?' ? -1 : c.to_i32 }.reverse
  n = s.size
  m = 13

  e = Mint13.new(1)
  dp = Array.new_md(n+1, m, Mint.zero)
  dp[0][0] = Mint.new(1)
  n.times do |i|
    m.times do |j|
      if t[i] == -1
        10.times do |k|
          dp[i+1][(e*k+j).to_i] += dp[i][j]
        end
      else
        dp[i+1][(e*t[i]+j).to_i] += dp[i][j]
      end
    end
    e *= 10
  end

  io.put dp[n][5]
end

require "lib/procon"

require "lib/math/mod_int"
ModInt.new_type(Mint, 10**9+7)
ModInt.new_type(Mint13, 13)

solve(ProconIO.new)
