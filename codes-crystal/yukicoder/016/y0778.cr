# URL: https://yukicoder.me/problems/no/778

def solve(io)
  n = io.get

  g = Graph.new(n)
  (n-1).times do |i|
    ai = io.get
    g.add_edge_b(i+1, ai)
  end
  t = g.tree(0)
  e = t.euler_tour

  f = FenwickTree(Int32).new(e.path.size)
  r = 0_i64
  (0...n).reverse_each do |u|
    r += f[e.in_time[u]..e.out_time[u]]
    f.add(e.in_time[u], 1)
  end

  io.put r
end

require "lib/procon"

require "lib/data_structure/fenwick_tree"

require "lib/graph/graph"

require "lib/graph/tree"

require "lib/graph/euler_tour"

solve(ProconIO.new)
