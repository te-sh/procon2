# URL: https://yukicoder.me/problems/no/898

def solve(io)
  n = io.get
  u, v, w = io.get3_c(n - 1); u.map!(&.- 1); v.map!(&.- 1)

  g = Graph.new(n)
  zip(u, v) do |ui, vi|
    g.add_edge_b(ui, vi)
  end
  t = g.tree(0)

  pw = Array.new(n, 0)
  zip(u, v, w) do |ui, vi, wi|
    if t.depth[ui] < t.depth[vi]
      pw[vi] = wi
    else
      pw[ui] = wi
    end
  end

  sw = Array.new(n, 0_i64)
  t.dfs_order.each do |ui|
    sw[ui] = sw[t.parent[ui]] + pw[ui] unless ui == 0
  end

  hd = t.hl_decomposition
  q = io.get
  q.times do
    xi, yi, zi = io.get3; xi -= 1; yi -= 1; zi -= 1
    io.put sw[xi] + sw[yi] + sw[zi] - sw[hd.lca(xi, yi)] - sw[hd.lca(yi, zi)] - sw[hd.lca(zi, xi)]
  end
end

require "lib/procon"

require "lib/graph/graph"

require "lib/graph/tree"

require "lib/graph/hl_decomposition"

solve(ProconIO.new)
