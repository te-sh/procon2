# URL: https://yukicoder.me/problems/no/826

require "bit_array"

def solve(io)
  n, p = io.get2

  uf = UnionFind.new(n+1)
  b = BitArray.new(n+1)

  (2..n).each do |i|
    next if b[i]
    j = i*2
    while j <= n
      b[j] = true
      uf.unite(i, j)
      j += i
    end
  end

  io.put uf.count_nodes_of(p)
end

require "lib/data_structure/union_find"

require "lib/procon"

solve(ProconIO.new)
