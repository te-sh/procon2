# URL: https://yukicoder.me/problems/no/865

def solve(io)
  n = io.get
  a = io.get_a(n)

  m = n - 24

  st1 = SegmentTree.new(a) { |a, b| a + b }
  st2 = SegmentTree(Int32).new(m + 1) { |a, b| {a, b}.max }
  (0..m).each do |i|
    st2[i] = st1[i, 24]
  end

  q = io.get
  q.times do
    ti, vi = io.get2; ti -= 1
    st1[ti] = vi
    ((ti - 23).clamp(0..)..ti.clamp(..m)).each do |i|
      st2[i] = st1[i, 24]
    end
    io.put st2[0..]
  end
end

require "lib/procon"

require "lib/data_structure/segment_tree"

solve(ProconIO.new)
