# URL: https://atcoder.jp/contests/abc141/tasks/abc141_e

def solve(io)
  n = io.get
  s = io.get(String)

  sa = SuffixArray.new(s)
  lcp = LcpArray.new(sa)
  st = SparseTable.new(lcp[1..]) { |a, b| Math.min(a, b) }

  r = 0
  (0...n).each do |i|
    (i+1...n).each do |j|
      l = st[i...j]
      x, y = sa[i], sa[j]
      max_u(r, l) if x < y && x+l <= y || x > y && y+l <= x
    end
  end

  io.put r
end

require "lib/string/suffix_array"

require "lib/string/lcp_array"

require "lib/data_structure/sparse_table"

require "lib/procon"

solve(ProconIO.new)
