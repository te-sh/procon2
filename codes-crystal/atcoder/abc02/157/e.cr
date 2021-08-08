# URL: https://atcoder.jp/contests/abc157/tasks/abc157_e

def solve(io)
  n = io.get
  s = io.get(String)

  a = s.chars.map { |si| 1 << (si - 'a') }
  st = SegmentTree.new(a) { |a, b| a | b }

  q = io.get
  q.times do
    tq = io.get
    case tq
    when 1
      iq, cq = io.get(Int32, String); iq -= 1
      st[iq] = 1 << (cq[0] - 'a')
    when 2
      lq, rq = io.get2; lq -= 1; rq -= 1
      io.put st[lq..rq].popcount
    end
  end
end

require "lib/procon"

require "lib/data_structure/segment_tree"

solve(ProconIO.new)
