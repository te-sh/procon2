# URL: https://yukicoder.me/problems/no/807

def solve(io)
  n, m = io.get2
  g = GraphW(Int64).new(n*2, 10_i64**18)
  m.times do
    ai, bi, ci = io.get(Int32, Int32, Int64); ai -= 1; bi -= 1
    g.add_edge_b(ai, bi, ci)
    g.add_edge_b(ai+n, bi+n, ci)
    g.add_edge(ai, bi+n, 0_i64)
    g.add_edge(bi, ai+n, 0_i64)
  end
  n.times do |i|
    g.add_edge(i, i+n, 0_i64)
  end

  d = g.dijkstra(0).dist

  n.times do |i|
    io.put d[i] + d[i+n]
  end
end

require "lib/procon"

require "lib/graph/graph"

require "lib/graph/dijkstra"

solve(ProconIO.new)
