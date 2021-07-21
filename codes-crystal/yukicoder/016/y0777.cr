# URL: https://yukicoder.me/problems/no/777

def solve(io)
  n = io.get
  a, b, c = io.get_c(n, Int32, Int32, Int64)

  za = Zaatsu.new(b)
  d = Array.new(n) { |i| Cake.new(a[i], za.comp(b[i]), c[i]) }

  d.sort_by! { |di| {-di.a, di.b, -di.c} }
  d.uniq! { |di| {di.a, di.b} }

  st = SegmentTree(Int64).new(za.size) { |a, b| {a, b}.max }
  d.each do |di|
    max_u(st[di.b], st[di.b+1..] + di.c)
  end

  io.put st[0..]
end

record Cake, a : Int32, b : Int32, c : Int64

require "lib/procon"

require "lib/data_structure/zaatsu"

require "lib/data_structure/segment_tree"

solve(ProconIO.new)
