# URL: https://atcoder.jp/contests/abc145/tasks/abc145_c

def solve(io)
  n = io.get
  x, y = io.get2_c(n, Float64)
  p = Array.new(n) { |i| Point.new(x[i], y[i]) }

  c = 0
  s = 0.0
  p.each_permutation(n) do |q|
    q.each_cons_pair do |q1, q2|
      s += Geom.dist(q1, q2)
    end
    c += 1
  end

  io.put s / c
end

require "lib/procon"

require "lib/math/geom"
alias Point = Geom::Point

solve(ProconIO.new)
