# URL: https://yukicoder.me/problems/no/860

def solve(io)
  n = io.get
  c, d = io.get2_c(n, Int64)

  e = [] of GraphW::Edge(Int64)
  n.times do |u|
    e << GraphW::Edge(Int64).new(u, n, c[u])
  end
  (1...n).each do |u|
    e << GraphW::Edge(Int64).new(u-1, u, d[u])
  end

  e.sort_by! { |ei| ei.wt }
  uf = UnionFind.new(n+1)
  r = 0_i64
  e.each do |ei|
    next if uf.same?(ei.src, ei.dst)
    uf.unite(ei.src, ei.dst)
    r += ei.wt
    break if uf.count_forests == 1
  end

  io.put c.sum + r
end

require "lib/procon"

require "lib/data_structure/union_find"

require "lib/graph/graph"

solve(ProconIO.new)
