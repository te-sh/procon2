# URL: https://yukicoder.me/problems/no/783

def solve(io)
  n, c = io.get2
  l = io.get_a(n)
  w = io.get_a(n)

  ml = l.max
  dp = Array.new_md(c+1, ml+1, ml+1, 0)
  zip(l, w) do |li1, wi1|
    zip(l, w) do |li2, wi2|
      zip(l, w) do |li3, wi3|
        if li1 != li2 && li2 != li3 && li3 != li1 && (li1 > li2 && li2 < li3 || li1 < li2 && li2 > li3) &&
           c - wi1 - wi2 - wi3 >= 0
          max_u(dp[c - wi1 - wi2 - wi3][li2][li3], li1 + li2 + li3)
        end
      end
    end
  end

  (1..c).reverse_each do |i|
    (1..ml).each do |j2|
      (1..ml).each do |j1|
        zip(l, w) do |li, wi|
          if dp[i][j2][j1] > 0 && j2 != li && j1 != li && (j2 > j1 && j1 < li || j2 < j1 && j1 > li) && i - wi >= 0
            max_u(dp[i - wi][j1][li], dp[i][j2][j1] + li)
          end
        end
      end
    end
  end

  io.put dp.flatten.max
end

require "lib/procon"

solve(ProconIO.new)
