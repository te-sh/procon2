# URL: https://yukicoder.me/problems/no/776

def solve(io)
  n, q = io.get2
  a = io.get_a(n, Int64)

  inf = 10_i64**18
  items = a.map { |ai| Item.new(ai, ai, ai, ai) }
  st = SegmentTree.new(items, Item.new(0_i64, -inf, -inf, -inf)) do |l, r|
    Item.new(
      l.s + r.s,
      {l.t, l.s + r.t}.max,
      {r.u, l.u + r.s}.max,
      {l.v, r.v, l.u + r.t}.max
    )
  end

  q.times do
    k = io.get(String)
    case k
    when "set"
      i, x = io.get(Int32, Int64); i -= 1
      st[i] = Item.new(x, x, x, x)
    when "max"
      l1, l2, r1, r2 = io.get4; l1 -= 1; l2 -= 1; r1 -= 1; r2 -= 1
      r1 = r1.clamp(l1..)
      l2 = l2.clamp(..r2)
      if l2 < r1
        io.put st[l1..l2].u + st[l2..r1].s + st[r1..r2].t - st[l2].s - st[r1].s
      else
        m1 = st[l1..r1].u + st[r1..r2].t - st[r1].s
        m2 = st[l1..l2].u + st[l2..r2].t - st[l2].s
        m3 = st[r1..l2].v
        io.put({m1, m2, m3}.max)
      end
    end
  end
end

record Item, s : Int64, t : Int64, u : Int64, v : Int64

require "lib/procon"

require "lib/data_structure/segment_tree"

solve(ProconIO.new)
