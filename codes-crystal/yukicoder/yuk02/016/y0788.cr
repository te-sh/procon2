# URL: https://yukicoder.me/problems/no/788

def solve(io)
  n, m, l = io.get3; l -= 1
  t = io.get_a(n)

  io.put_e 0 if t.count(&.> 0) == 1

  g = GraphW(Int64).new(n, 10_i64**18)
  m.times do
    a, b, c = io.get(Int32, Int32, Int64) a -= 1; b -= 1
    g.add_edge_b(a, b, c)
  end

  dist = Array.new(n) { |i| g.dijkstra(i).dist }

  r = g.inf
  (0...n).each do |c|
    s = zip(dist[c], t).map { |a, b| a * b }.sum * 2
    (0...n).each do |f|
      min_u(r, s + dist[l][f] - dist[f][c]) if t[f] > 0
    end
  end

  io.put r
end

require "lib/procon"

require "lib/graph/graph"

require "lib/graph/dijkstra"

solve(ProconIO.new)
