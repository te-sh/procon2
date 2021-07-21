require "spec"
require "../../lib/graph/graph"
require "../../lib/graph/tree"

module TreeSpec
  describe Tree do
    g = Graph.new(13)
    [
      {0, 1}, {0, 2}, {1, 3}, {1, 4}, {1, 5}, {2, 6},
      {4, 7}, {4, 8}, {6, 10}, {6, 11}, {11, 12}, {8, 9}
    ].each do |u, v|
      g.add_edge_b(u, v)
    end

    t = g.tree(0)

    it { t.root.should eq 0 }

    it { t.dfs_order.should eq [0, 2, 6, 11, 12, 10, 1, 5, 4, 8, 9, 7, 3] }

    it { t.parent[0].should eq 0 }
    it { t.parent[1].should eq 0 }
    it { t.parent[3].should eq 1 }

    it { t.depth[0].should eq 0 }
    it { t.depth[1].should eq 1 }
    it { t.depth[3].should eq 2 }

    it { t.descendant_size[0].should eq 13 }
    it { t.descendant_size[1].should eq 7 }
    it { t.descendant_size[3].should eq 1 }

    it { t.children[0].should eq [1, 2] }
    it { t.children[1].should eq [3, 4, 5] }
    it { t.children[3].empty?.should be_true }
  end
end
