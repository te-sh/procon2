# URL: https://yukicoder.me/problems/no/759

def solve(io)
  n = io.get
  p, t, r = io.get3_c(n)
  s = Array.new(n) { |i| Shop.new(p[i]+1, t[i]+1, r[i]+1, i) }

  s.sort_by! { |si| [-si.p, -si.t, -si.r] }
  st = SegmentTree(Int32).new(10**4+2) { |a, b| Math.max(a, b) }
  b = Array.new(n, true)

  s.each do |si|
    b[si.i] = false if st[si.t..] >= si.r
    max_u(st[si.t], si.r)
  end

  n.times do |i|
    io.put i+1 if b[i]
  end
end

record Shop, p : Int32, t : Int32, r : Int32, i : Int32

require "lib/procon"

require "lib/data_structure/segment_tree"

solve(ProconIO.new)
