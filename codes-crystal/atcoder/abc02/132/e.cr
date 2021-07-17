# URL: https://atcoder.jp/contests/abc132/tasks/abc132_e

def solve(io)
  n, m = io.get2

  g = GraphW(Int32).new(n*3)
  m.times do
    u, v = io.get2; u -= 1; v -= 1
    g.add_edge(u, v+n, 1)
    g.add_edge(u+n, v+n*2, 1)
    g.add_edge(u+n*2, v, 1)
  end
  s, t = io.get2; s -= 1; t -= 1

  dist = g.dijkstra(s).dist
  io.put dist[t] < g.inf ? dist[t]//3 : -1
end

require "lib/graph/dijkstra"

require "lib/procon"

solve(ProconIO.new)
