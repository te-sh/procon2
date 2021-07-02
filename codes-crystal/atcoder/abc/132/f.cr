# URL: https://atcoder.jp/contests/abc132/tasks/abc132_f

def main(io)
  n, k = io.get2
  s = isqrt(n)
  t = (1..s).map { |i| Math.max(s, n//i) }
  t << s
  t.reverse!

  dp1 = Array.new(k) { Array.new(s+1, Mint.zero) }
  dp2 = Array.new(k) { Array.new(s+1, Mint.zero) }
  (1..s).each do |i|
    dp1[0][i] = Mint.new(1)
    dp2[0][i] = Mint.new(t[i] - t[i-1])
  end

  (0...k-1).each do |i|
    c1 = CumulativeSum.new(dp1[i])
    c2 = CumulativeSum.new(dp2[i])
    (1..s).each do |j|
      dp1[i+1][j] = c1[0..] + c2[0..-j]
      dp2[i+1][j] = c1[0..-j] * (t[j] - t[j-1])
    end
  end

  io.put dp1[k-1].sum + dp2[k-1].sum
end

require "lib/data_structure/cumulative_sum"

require "lib/math/misc"

require "lib/math/mod_int"
struct Mint < ModInt; @@mod : Int32 = 10**9+7; end

require "lib/procon_io"

main(ProconIO.new)
