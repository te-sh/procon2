# URL: https://atcoder.jp/contests/abc154/tasks/abc154_e

def solve(io)
  n = io.get(String)
  k = io.get

  d = n.each_char.map(&.to_i).to_a
  m = d.size
  dp = Array.new_md(m + 1, 2, k + 2, 0)
  dp[0][1][0] = 1
  (0...m).each do |x|
    (0..1).each do |y|
      (0..k).each do |z|
        (y == 1 ? (0..d[x]) : (0..9)).each do |w|
          dp[x + 1][y == 1 && w == d[x] ? 1 : 0][z + (w > 0 ? 1 : 0)] += dp[x][y][z]
        end
      end
    end
  end

  io.put dp[m][0][k] + dp[m][1][k]
end

require "lib/procon"

solve(ProconIO.new)
