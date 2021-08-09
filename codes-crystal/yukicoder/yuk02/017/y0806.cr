# URL: https://yukicoder.me/problems/no/806

def solve(io)
  n = io.get
  g = Graph.new(n)
  (n-1).times do
    ai, bi = io.get2; ai -= 1; bi -= 1
    g.add_edge_b(ai, bi)
  end

  io.put (0...n).count { |u| g[u].size == 1 } - 2
end

require "lib/procon"

require "lib/graph/graph"

solve(ProconIO.new)
