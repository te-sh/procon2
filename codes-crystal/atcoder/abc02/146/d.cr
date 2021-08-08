# URL: https://atcoder.jp/contests/abc146/tasks/abc146_d

def solve(io)
  n = io.get
  a, b = io.get2_c(n - 1); a.map!(&.- 1); b.map!(&.- 1)

  g = Graph.new(n)
  c = Array.new(n) { Hash(Int32, Int32).new }
  zip(a, b) do |ai, bi|
    g.add_edge_b(ai, bi)
    c[ai][bi] = c[bi][ai] = 0
  end
  t = g.tree(0)

  q = Deque{0}
  until q.empty?
    u = q.shift
    cc = 1
    t.children[u].each do |v|
      cc += 1 if u != 0 && cc == c[u][t.parent[u]]
      c[u][v] = c[v][u] = cc
      cc += 1
      q.push(v)
    end
  end

  io.put c.map(&.values.max).max
  zip(a, b) do |ai, bi|
    io.put c[ai][bi]
  end
end

require "lib/procon"

require "lib/graph/graph"

require "lib/graph/tree"

solve(ProconIO.new)
