# URL: https://atcoder.jp/contests/abc153/tasks/abc153_f

def solve(io)
  n, d, a = io.get3
  x, h = io.get2_c(n, Int64)
  m = Array.new(n) { |i| Monster.new(x[i], h[i].cdiv(a)) }
  m.sort_by!(&.x)

  r = 0_i64
  f = Array.new(n, 0_i64)
  (0...n).each do |i|
    f[i] += f[i - 1] if i > 0
    if f[i] < m[i].h
      e = m[i].h - f[i]
      j = m.bsearch_index { |mj| mj.x > m[i].x + d * 2 }
      r += e
      f[i] += e
      f[j] -= e unless j.nil?
    end
  end

  io.put r
end

record Monster, x : Int64, h : Int64

require "lib/procon"

solve(ProconIO.new)
