# URL: https://yukicoder.me/problems/no/1639

require "big"

def solve(io)
  n = io.get

  uf = UnionFind.new(n)
  (n * (n - 1) // 2).times do
    ai, bi, ci = io.get(Int32, Int32, String); ai -= 1; bi -= 1
    uf.unite(ai, bi)
    io.put_e ci if uf.count_forests == 1
  end
end

require "lib/procon"

require "lib/data_structure/union_find"

solve(ProconIO.new)
