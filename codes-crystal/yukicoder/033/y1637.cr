# URL: https://yukicoder.me/problems/no/1637

def solve(io)
  n, q = io.get2

  g = Graph.new(n)
  (n - 1).times do
    ai, bi = io.get2; ai -= 1; bi -= 1
    g.add_edge_b(ai, bi)
  end
  t = g.tree(0)

  c = 0_i64
  q.times do
    pi, xi = io.get(Int32, Int64); pi -= 1
    c += xi * t.descendant_size[pi]
    io.put c
  end
end

require "lib/procon"

require "lib/graph/graph"

require "lib/graph/tree"

solve(ProconIO.new)
