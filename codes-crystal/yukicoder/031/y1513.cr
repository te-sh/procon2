# URL: https://yukicoder.me/problems/no/1513

def main(io)
  n, k = io.get2

  dp1 = Array.new(n) { Array.new(k) { Array.new(k, Mint.zero) } }
  dp2 = Array.new(n) { Array.new(k) { Array.new(k, Mint.zero) } }
  (0...k).each do |j|
    (0...k).each do |l|
      if j != l
        dp1[1][j][l] = Mint.new(1)
        dp2[1][j][l] = Mint.new(j+l)
      end
    end
  end

  (1...n-1).each do |i|
    (0...k).each do |j|
      c1 = CumulativeSum.new(Array.new(k) { |l| dp1[i][l][j] })
      c2 = CumulativeSum.new(Array.new(k) { |l| dp2[i][l][j] })
      (0...k).each do |l|
        if j > l
          dp1[i+1][j][l] = c1[...j] - dp1[i][l][j]
          dp2[i+1][j][l] = c2[...j] - dp2[i][l][j] + dp1[i+1][j][l]*l
        elsif j < l
          dp1[i+1][j][l] = c1[j+1...] - dp1[i][l][j]
          dp2[i+1][j][l] = c2[j+1...] - dp2[i][l][j] + dp1[i+1][j][l]*l
        end
      end
    end
  end

  ans1 = dp1[-1].map(&.sum).sum
  ans2 = dp2[-1].map(&.sum).sum
  io.put ans1, ans2
end

require "lib/data_structure/cumulative_sum"

require "lib/math/mod_int"
struct Mint < ModInt; @@mod : Int32 = 998244353; end

require "lib/procon_io"

main(ProconIO.new)
