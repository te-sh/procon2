# URL: https://yukicoder.me/problems/no/859

def solve(io)
  x, y, z = io.get3(Int64)
  s0, t0 = io.get(String, Int64)
  s1, t1 = io.get(String, Int64)

  g = GraphW(Int64).new(8, 10_i64**18)
  g.add_edge_b(0, 1, x - 1)
  g.add_edge_b(2, 3, y - 1)
  g.add_edge_b(4, 5, z - 1)
  g.add_edge_b(0, 2, 1)
  g.add_edge_b(2, 4, 1)
  g.add_edge_b(4, 0, 1)
  g.add_edge_b(1, 3, 1)
  g.add_edge_b(3, 5, 1)
  g.add_edge_b(5, 1, 1)

  if s0 == s1
    t0, t1 = t1, t0 if t0 > t1
    g.add_edge(6, 7, t1 - t0)

    case s0
    when "A"
      g.add_edge_b(0, 6, t0 - 1)
      g.add_edge_b(7, 1, x - t1)
    when "B"
      g.add_edge_b(2, 6, t0 - 1)
      g.add_edge_b(7, 3, y - t1)
    when "C"
      g.add_edge_b(4, 6, t0 - 1)
      g.add_edge_b(7, 5, z - t1)
    end
  else
    case s0
    when "A"
      g.add_edge_b(0, 6, t0 - 1)
      g.add_edge_b(6, 1, x - t0)
    when "B"
      g.add_edge_b(2, 6, t0 - 1)
      g.add_edge_b(6, 3, y - t0)
    when "C"
      g.add_edge_b(4, 6, t0 - 1)
      g.add_edge_b(6, 5, z - t0)
    end

    case s1
    when "A"
      g.add_edge_b(0, 7, t1 - 1)
      g.add_edge_b(7, 1, x - t1)
    when "B"
      g.add_edge_b(2, 7, t1 - 1)
      g.add_edge_b(7, 3, y - t1)
    when "C"
      g.add_edge_b(4, 7, t1 - 1)
      g.add_edge_b(7, 5, z - t1)
    end
  end

  io.put g.dijkstra(6).dist[7]
end

require "lib/procon"

require "lib/graph/graph"

require "lib/graph/dijkstra"

solve(ProconIO.new)
