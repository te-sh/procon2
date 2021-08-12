require "spec"
require "lib/graph/hl_decomposition"

module HlDecompositionSpec
  describe HlDecomposition do
    g = Graph.new(13)
    [
      {0, 1}, {0, 2}, {1, 3}, {1, 4}, {1, 5},
      {2, 6}, {4, 7}, {4, 8}, {6, 10}, {6, 11},
      {11, 12}, {8, 9}
    ].each do |u, v|
      g.add_edge_b(u, v)
    end

    t = g.tree(0)
    hd = t.hl_decomposition

    it { hd.head[0].should eq 0 }
    it { hd.head[1].should eq 0 }
    it { hd.head[3].should eq 3 }
    it { hd.head[4].should eq 0 }
    it { hd.head[6].should eq 2 }

    it { hd.lca(1, 3).should eq 1 }
    it { hd.lca(2, 3).should eq 0 }
    it { hd.lca(1, 8).should eq 1 }
    it { hd.lca(7, 9).should eq 4 }
  end
end
