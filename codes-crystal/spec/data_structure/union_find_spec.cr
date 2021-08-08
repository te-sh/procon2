require "spec"
require "lib/data_structure/union_find"

module UnionFindSpec
  describe UnionFind do
    uf = UnionFind.new(6)

    it {
      uf.count_forests.should eq 6

      uf.unite(0, 1)
      uf.same?(0, 1).should be_true
      uf.same?(0, 2).should be_false
      uf.count_forests.should eq 5
      uf.count_nodes(1).should eq 2

      uf.unite(0, 2)
      uf.same?(0, 1).should be_true
      uf.same?(0, 2).should be_true
      uf.count_forests.should eq 4
      uf.count_nodes(1).should eq 3
    }
  end
end
