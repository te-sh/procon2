# URL: https://atcoder.jp/contests/abc140/tasks/abc140_e

def main(io)
  n = io.get
  p = io.get_a(n)

  a = Array.new(n+1, 0)
  p.each_with_index do |pi, i|
    a[pi] = i
  end

  s = SegmentTree.new(p) { |a, b| Math.max(a, b) }
  c = 0_i64

  (1...n).each do |i|
    x = a[i]

    tl1 = (0...x).bsearch { |k| s[k...x] < i }
    l1 = tl1.nil? ? x-1 : tl1-1
    if l1 >= 0
      tl2 = (0...l1).bsearch { |k| s[k...l1] < i }
      l2 = tl2.nil? ? l1-1 : tl2-1
    else
      l2 = -1
    end

    tr1 = (x+1...n).bsearch { |k| s[x+1..k] > i }
    r1 = tr1.nil? ? n : tr1
    if r1 < n
      tr2 = (r1+1...n).bsearch { |k| s[r1+1..k] > i }
      r2 = tr2.nil? ? n : tr2
    else
      r2 = n
    end

    c += ((l1-l2).to_i64 * (r1-x) + (x-l1).to_i64 * (r2-r1)) * i
  end

  io.put c
end

require "lib/data_structure/segment_tree"

require "lib/procon_io"

main(ProconIO.new)
