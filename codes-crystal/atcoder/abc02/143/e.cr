# URL: https://atcoder.jp/contests/abc143/tasks/abc143_e

def solve(io)
  n, m, l = io.get3
  g1 = GraphM(Int64).new(n, 10_i64**18)
  m.times do
    a, b, c = io.get(Int32, Int32, Int64); a -= 1; b -= 1
    g1.add_edge_b(a, b, c)
  end

  dist1 = g1.floyd_warshal.dist
  g2 = GraphM(Int32).new(n)

  (0...n).each do |i|
    (i+1...n).each do |j|
      g2.add_edge_b(i, j, 1) if dist1[i][j] <= l
    end
  end

  dist2 = g2.floyd_warshal.dist

  q = io.get
  q.times do
    s, t = io.get2; s -= 1; t -= 1
    io.put dist2[s][t] == g2.inf ? -1 : dist2[s][t] - 1
  end
end

require "lib/procon"

require "lib/graph/graph"

require "lib/graph/floyd_warshal"

solve(ProconIO.new)
