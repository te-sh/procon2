# URL: https://yukicoder.me/problems/no/878

def solve(io)
  n, q = io.get2
  a = io.get_a(n)

  a2 = a.map_with_index { |ai, i| {ai, i} }
  a2.sort_by! { |ai, _| -ai }

  b = Array.new(n, -1)
  aat = AATree(Int32).new
  a2.each do |_, i|
    b[i] = aat.rsearch { |j| j < i } || -1
    aat.insert(i)
  end

  b2 = b.map_with_index { |bi, i| {bi, i} }
  b2.sort_by! { |bi, _| bi }

  r = Array.new(q) do |i|
    ti, li, ri = io.get3; li -= 1; ri -= 1
    {li, ri, i}
  end
  r.sort_by! { |li, _, _| li }

  j = 0
  ft = FenwickTree(Int32).new(n)
  ans = Array.new(q, 0)
  r.each do |li, ri, i|
    while b2[j][0] < li
      ft.add(b2[j][1], 1)
      j += 1
    end
    ans[i] = ft[li..ri]
  end

  ans.each do |v|
    io.put v
  end
end

require "lib/procon"

require "lib/data_structure/fenwick_tree"

require "lib/data_structure/aa_tree"

solve(ProconIO.new)
