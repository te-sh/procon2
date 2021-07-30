# URL: https://yukicoder.me/problems/no/877

def solve(io)
  n, q = io.get2
  a = io.get_a(n, Int64)
  t, l, r, x = io.get_c(q, Int32, Int32, Int32, Int64); l.map!(&.- 1); r.map!(&.- 1)

  b = a.map_with_index { |ai, i| Item.new(ai, i) }.sort_by(&.v).reverse
  b << Item.new(0, n)

  r = zip(l, r, x).map_with_index { |(li, ri, xi), i| Query.new(li, ri, xi, i) }.sort_by(&.x).reverse

  i = 0
  s1 = SegmentTree.new(n, 0_i64) { |a, b| a + b }
  s2 = SegmentTree.new(n, 0) { |a, b| a + b }
  ans = Array.new(q, 0_i64)
  r.each do |ri|
    while b[i].v >= ri.x
      s1[b[i].i] = b[i].v
      s2[b[i].i] = 1
      i += 1
    end
    ans[ri.i] = s1[ri.l..ri.r] - ri.x * s2[ri.l..ri.r]
  end

  ans.each do |v|
    io.put v
  end
end

record Item, v : Int64, i : Int32
record Query, l : Int32, r : Int32, x : Int64, i : Int32

require "lib/procon"

require "lib/data_structure/segment_tree"

solve(ProconIO.new)
