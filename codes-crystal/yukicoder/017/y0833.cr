# URL: https://yukicoder.me/problems/no/833

def solve(io)
  n, q = io.get2
  a = io.get_a(n, Int64)

  s1 = SegmentTree.new(a) { |a, b| a + b }
  s2 = SegmentTree.new(Array.new(n+1, 1)) { |a, b| a + b }

  q.times do
    t, x = io.get2; x -= 1
    case t
    when 1
      s2[x+1] = 0
    when 2
      s2[x+1] = 1
    when 3
      s1[x] += 1
    when 4
      i = s2[..x]
      l = (0..x).bsearch { |j| s2[..j] >= i }
      r = (x..n).bsearch { |j| s2[..j] > i }
      io.put s1[l...r]
    end
  end
end

require "lib/data_structure/segment_tree"

require "lib/procon"

solve(ProconIO.new)
