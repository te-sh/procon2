# URL: https://yukicoder.me/problems/no/871

def solve(io)
  n, k = io.get2; k -= 1
  x = io.get_a(n, Int64)
  a = io.get_a(n, Int64)

  l = Array.new(n) do |i|
    x.bsearch_index { |xj| xj >= x[i] - a[i] } || n
  end
  r = Array.new(n) do |i|
    (x.bsearch_index { |xj| xj > x[i] + a[i] } || n) - 1
  end

  sl = SparseTable.new(l) { |a, b| {a, b}.min }
  sr = SparseTable.new(r) { |a, b| {a, b}.max }

  i = j = k
  loop do
    i2, j2 = sl[i..j], sr[i..j]
    break if i == i2 && j == j2
    i, j = i2, j2
  end

  io.put j - i + 1
end

require "lib/procon"

require "lib/data_structure/sparse_table"

solve(ProconIO.new)
