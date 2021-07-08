require "spec"
require "lib/data_structure/fenwick_tree"

module FenwickSpec
  describe FenwickTree do
    f = FenwickTree(Int32).new(15)

    it do
      f[0...2].should eq 0
      f[0..2].should eq 0
      f[...6].should eq 0
      f[1, 3].should eq 0
      f[5..].should eq 0

      f.add(1, 2)
      f[0...2].should eq 2
      f[0..2].should eq 2
      f[...6].should eq 2
      f[1, 3].should eq 2
      f[5..].should eq 0

      f.add(2, 3)
      f.add(5, 4)
      f.add(10, -5)
      f.add(14, 2)
      f[0...2].should eq 2
      f[0..2].should eq 5
      f[...6].should eq 9
      f[1, 3].should eq 5
      f[5..].should eq 1
    end
  end
end
