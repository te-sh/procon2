# URL: https://yukicoder.me/problems/no/758

def solve(io)
  n = io.get

  io.put_e 1 if n == 1

  g = Graph.new(n)
  (n-1).times do
    a, b = io.get2; a -= 1; b -= 1
    g.add_edge_b(a, b)
  end
  t = g.tree(0)

  x = (0...n).count { |u| t.children_of(u).empty? }
  f = Fact(Mint).new(n-1)
  io.put f.combi(n-1, x-1) * f.combi(n-2, x-1) // x
end

require "lib/procon"

require "lib/math/fact"

require "lib/math/mod_int"
ModInt.new_type(Mint, 10**9+7)

require "lib/graph/graph"

require "lib/graph/tree"

solve(ProconIO.new)
