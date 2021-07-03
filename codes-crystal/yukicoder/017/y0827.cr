# URL: https://yukicoder.me/problems/no/827

def main(io)
  n = io.get
  g = Graph.new(n)
  (n-1).times do
    u, v = io.get2; u -= 1; v -= 1
    g.add_edge_b(u, v)
  end
  t = g.tree(0)

  f = Fact(Mint).new(n)
  r = Mint.zero
  (0...n).each do |u|
    d = t.depth_of(u)
    r += f.combi(n, d+1) * f.fact(d) * f.fact(n-d-1)
  end

  io.put r
end

require "lib/graph/graph"

require "lib/graph/tree"

require "lib/math/fact"

require "lib/math/mod_int"
struct Mint < ModInt; @@mod : Int32 = 10**9+7; end

require "lib/procon_io"

main(ProconIO.new)
