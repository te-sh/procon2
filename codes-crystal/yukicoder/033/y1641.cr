# URL: https://yukicoder.me/problems/no/1641

def solve(io)
  n, q = io.get2
  c = io.get_a(n)

  g = Graph.new(n)
  (n - 1).times do
    ai, bi = io.get2; ai -= 1; bi -= 1;
    g.add_edge_b(ai, bi)
  end
  t = g.tree(0)
  et = t.euler_tour

  st = SegmentTree(Int32).new(et.path.size) { |a, b| a ^ b }
  n.times do |i|
    st[et.in_time[i]] = c[i]
  end

  q.times do
    ti, xi, yi = io.get3; xi -= 1
    case ti
    when 1
      st[et.in_time[xi]] ^= yi
    when 2
      io.put st[et.in_time[xi]..et.out_time[xi]]
    end
  end
end

require "lib/procon"

require "lib/data_structure/segment_tree"

require "lib/graph/graph"

require "lib/graph/tree"

require "lib/graph/euler_tour"

solve(ProconIO.new)
