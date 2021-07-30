# URL: https://yukicoder.me/problems/no/872

def solve(io)
  n = io.get
  u, v, w = io.get_c(n - 1, Int32, Int32, Int64); u.map!(&.- 1); v.map!(&.- 1)

  g = Graph.new(n)
  zip(u, v).each do |ui, vi|
    g.add_edge_b(ui, vi)
  end
  t = g.tree(0)

  e = Array.new(n, 0_i64)
  zip(u, v, w).each do |ui, vi, wi|
    e[t.depth[ui] > t.depth[vi] ? ui : vi] = wi
  end

  ans = 0_i64
  (1...n).each do |u|
    p = t.descendant_size[u]
    ans += e[u] * p * (n - p)
  end

  io.put ans * 2
end

require "lib/procon"

require "lib/graph/graph"

require "lib/graph/tree"

solve(ProconIO.new)
