# URL: https://atcoder.jp/contests/abc152/tasks/abc152_f

def solve(io)
  n = io.get

  g = Graph.new(n)
  e = Array.new_md(n, n, -1)
  (n - 1).times do |i|
    ai, bi = io.get2; ai -= 1; bi -= 1
    g.add_edge_b(ai, bi)
    e[ai][bi] = e[bi][ai] = i
  end

  root = 0
  t = g.tree(root)

  p = Array.new(n, 0_i64)
  t.dfs_order.each do |u|
    unless u == root
      p[u] = p[t.parent[u]].set_bit(e[u][t.parent[u]])
    end
  end

  m = io.get
  q = Array.new(m, 0_i64)
  m.times do |i|
    ui, vi = io.get2; ui -= 1; vi -= 1
    q[i] = p[ui] ^ p[vi]
  end

  r = 0_i64
  (0...(1 << m)).each do |i|
    q2 = 0_i64
    (0...m).each do |j|
      q2 |= q[j] if i.bit?(j)
    end
    r += 2_i64 ** (n - 1 - q2.popcount) * (-1) ** i.popcount
  end

  io.put r
end

require "lib/procon"

require "lib/graph/graph"

require "lib/graph/tree"

solve(ProconIO.new)
