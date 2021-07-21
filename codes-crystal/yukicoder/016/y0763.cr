# URL: https://yukicoder.me/problems/no/763

def solve(io)
  n = io.get

  g = Graph.new(n)
  (n-1).times do
    u, v = io.get2; u -= 1; v -= 1
    g.add_edge_b(u, v)
  end
  t = g.tree(0)

  a = Array.new(n, 0)
  b = Array.new(n, 0)

  t.dfs_order.reverse_each do |u|
    a[u] = 1
    t.children[u].each do |v|
      a[u] += Math.max(a[v]-1, b[v])
      b[u] += Math.max(a[v], b[v])
    end
  end

  io.put Math.max(a[0], b[0])
end

require "lib/procon"

require "lib/graph/graph"

require "lib/graph/tree"

solve(ProconIO.new)
