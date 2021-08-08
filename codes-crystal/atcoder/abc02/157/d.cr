# URL: https://atcoder.jp/contests/abc157/tasks/abc157_d

def solve(io)
  n, m, k = io.get3

  uf = UnionFind.new(n)
  g1 = Graph.new(n)
  m.times do
    ai, bi = io.get2; ai -= 1; bi -= 1
    uf.unite(ai, bi)
    g1.add_edge_b(ai, bi)
  end

  g2 = Graph.new(n)
  k.times do
    ci, di = io.get2; ci -= 1; di -= 1
    g2.add_edge_b(ci, di)
  end

  r = Array.new(n) do |u|
    ri = uf.count_nodes(u) - 1
    g1[u].each do |v|
      ri -= 1 if uf.same?(u, v)
    end
    g2[u].each do |v|
      ri -= 1 if uf.same?(u, v)
    end
    ri
  end

  io.put r
end

require "lib/procon"

require "lib/data_structure/union_find"

require "lib/graph/graph"

solve(ProconIO.new)
