# URL: https://atcoder.jp/contests/abc133/tasks/abc133_e

def main(io)
  n, k = io.get2

  g = Graph.new(n)
  (n-1).times do
    u, v = io.get2; u -= 1; v -= 1
    g.add_edge_b(u, v)
  end
  t = g.tree(0)

  f = Fact(Mint).new(k)

  num_colors = uninitialized Graph::Node -> Mint
  num_colors = ->(u : Graph::Node) {
    children = t.children_of(u)
    return Mint.zero if children.size > k-2
    r = f.perm(k-2, children.size)
    c = children.map { |v| num_colors.call(v) }
    r * c.product
  }

  children = t.children_of(0)
  io.put_e(0) if children.size > k-1
  r = f.perm(k-1, children.size) * k
  c = children.map { |v| num_colors.call(v) }
  io.put r * c.product
end

require "lib/graph/graph"

require "lib/graph/tree"

require "lib/math/fact"

require "lib/math/mod_int"
struct Mint < ModInt; @@mod : Int32 = 10**9+7; end

require "lib/procon_io"

main(ProconIO.new)
