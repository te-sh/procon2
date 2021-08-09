# URL: https://yukicoder.me/problems/no/1507

def solve(io)
  n = io.get
  g = Graph.new(n)

  (n-1).times do
    ui, vi = io.get2; ui -= 1; vi -= 1
    g.add_edge_b(ui, vi)
  end
  t = g.tree(0)
  ds = t.descendant_size

  r = Mint.zero
  (1...n).each do |u|
    d1 = Mint.new(ds[0])
    d2 = Mint.new(ds[u])
    d3 = Mint.new(ds[0] - ds[u])
    r += (d3*(d3-1)//2 + d2*(d2-1)//2)//(d1*(d1-1)//2)
  end

  io.put r//(n-1)
end

require "lib/graph/graph"

require "lib/graph/tree"

require "lib/math/mod_int"
ModInt.new_type(Mint, 998244353)

require "lib/procon"

solve(ProconIO.new)
