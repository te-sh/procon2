# URL: https://atcoder.jp/contests/abc157/tasks/abc157_f

def solve(io)
  n, k = io.get2
  x, y, c = io.get3_c(n, Float64)
  p = Array.new(n) { |i| Geom::Point.new(x[i], y[i]) }
  eps = 10.0 ** (-10)

  io.put (0.0 .. 10.0 ** 18).bsearch { |t|
    m = 0
    (0...n).each do |i|
      s = 0
      (0...n).each do |j|
        s += 1 if Geom.dist(p[i], p[j]) < t / c[j] + eps
      end
      max_u(m, s)
    end

    (0...n).to_a.each_combination(2) do |(i1, i2)|
      c1 = Geom::Circle.new(p[i1], t / c[i1])
      c2 = Geom::Circle.new(p[i2], t / c[i2])
      sc = Geom.intersect(c1, c2)
      next if sc.nil?
      sc.each do |pi|
        s = 0
        (0...n).each do |j|
          s += 1 if Geom.dist(pi, p[j]) <= t / c[j] + eps
        end
        max_u(m, s)
      end
    end
    m >= k
  }
end

require "lib/procon"

require "lib/math/geom"

solve(ProconIO.new)
