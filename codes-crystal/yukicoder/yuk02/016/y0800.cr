# URL: https://yukicoder.me/problems/no/800

def solve(io)
  n, d = io.get2

  t = Array.new(n*n*2+1, 0)
  (1..n).each do |x|
    (1..n).each do |y|
      t[x*x+y*y] += 1
    end
  end

  r = 0_i64
  (1..n).each do |z|
    (1..n).each do |w|
      v = w*w-z*z+d
      r += t[v] if v >= 2 && v <= n*n*2
    end
  end

  io.put r
end

require "lib/procon"

solve(ProconIO.new)
