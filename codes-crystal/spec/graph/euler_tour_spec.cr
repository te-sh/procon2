require "spec"
require "../../lib/graph/graph"
require "../../lib/graph/tree"
require "../../lib/graph/euler_tour"

module EulerTourSpec
  describe Tree do
    g = Graph.new(13)
    [
      {0, 1}, {0, 2}, {1, 3}, {1, 4}, {1, 5}, {2, 6},
      {4, 7}, {4, 8}, {6, 10}, {6, 11}, {11, 12}, {8, 9}
    ].each do |u, v|
      g.add_edge_b(u, v)
    end

    t = g.tree(0)
    e = t.euler_tour

    it { e.path.should eq [0, 2, 6, 11, 12, 12, 11, 6, 10, 10, 6, 2, 0, 1, 5, 5, 1, 4, 8, 9, 9, 8, 4, 7, 7, 4, 1, 3, 3, 1, 0] }
    it { e.in_time.should eq [0, 13, 1, 27, 17, 14, 2, 23, 18, 19, 8, 3, 4] }
    it { e.out_time.should eq [30, 29, 11, 28, 25, 15, 10, 24, 21, 20, 9, 6, 5] }
  end
end
