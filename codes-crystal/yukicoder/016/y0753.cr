# URL: https://yukicoder.me/problems/no/753

def solve(io)
  n = 16
  a = io.get_m(n, n)

  (0...n).each do |i|
    (i+1...n).each do |j|
      a[i][j] = a[j][i] = a[i][j] == 1 ? i : j
    end
  end

  b = Array.new(3) { [] of Int32 }
  c = Array.new(1 << n) { [] of Int32 }
  (1 << n).times do |i|
    j = i.popcount
    if j.popcount == 1
      tzc = j.trailing_zeros_count
      b[tzc] << i if tzc < 3
      if tzc < 4
        n.times do |k|
          c[i] << k if i.bit?(k)
        end
      end
    end
  end

  dp = Array.new_md(1 << n, n, 0_i64)
  b[0].each do |bi|
    dp[bi][bi.trailing_zeros_count] = 1_i64
  end

  3.times do |k|
    b[k].each do |bi|
      b[k].each do |bj|
        if (bi & bj) == 0
          c[bi].each do |ci|
            c[bj].each do |cj|
              dp[bi | bj][a[ci][cj]] += dp[bi][ci] * dp[bj][cj]
            end
          end
        end
      end
    end
  end

  (1 << n).times do |i|
    if i.popcount == 8
      j = (i ^ ((1 << 16) - 1))
      c[i].each do |ci|
        c[j].each do |cj|
          dp[i | j][a[ci][cj]] += dp[i][ci] * dp[j][cj]
        end
      end
    end
  end

  n.times do |i|
    io.put dp[-1][i]
  end
end

require "lib/procon"

solve(ProconIO.new)
