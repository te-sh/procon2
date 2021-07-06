require "spec"
require "lib/data_structure/sparse_table"

module SparseTableSpec
  describe SparseTable do
    describe "merge is min" do
      s = SparseTable.new([1, 5, 9, 2, 4, 1, 3]) { |a, b| Math.min(a, b) }
      it { s[0...1].should eq 1 }
      it { s[...3].should eq 1 }
      it { s[1..3].should eq 2 }
      it { s[4..].should eq 1 }
    end

    describe "merge is max" do
      s = SparseTable.new([1, 5, 9, 2, 4, 1, 3]) { |a, b| Math.max(a, b) }
      it { s[0...1].should eq 1 }
      it { s[...3].should eq 9 }
      it { s[1..3].should eq 9 }
      it { s[4..].should eq 4 }
    end
  end
end
