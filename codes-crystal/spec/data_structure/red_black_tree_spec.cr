require "spec"
require "lib/data_structure/red_black_tree"

module RedBlackTreeSpec
  describe RedBlackTree do
    describe "#push" do
      rbt = RedBlackTree(Int32).new

      it do
        rbt.size.should eq 0

        rbt.push(2)
        rbt.size.should eq 1
        rbt.min.should eq 2
        rbt.max.should eq 2

        rbt.push(3)
        rbt.size.should eq 2
        rbt.min.should eq 2
        rbt.max.should eq 3

        rbt.push(1)
        rbt.size.should eq 3
        rbt.min.should eq 1
        rbt.max.should eq 3

        rbt.push(6)
        rbt.size.should eq 4
        rbt.min.should eq 1
        rbt.max.should eq 6

        rbt.push(4)
        rbt.size.should eq 5
        rbt.min.should eq 1
        rbt.max.should eq 6
      end
    end

    describe "#includes? and #search" do
      rbt = RedBlackTree(Int32).new
      [2, 3, 1, 6, 4].each do |i|
        rbt.push(i)
      end

      it { rbt.includes?(3).should be_true }
      it { rbt.includes?(5).should be_false }
      it { rbt.search { |i| i >= 2 }.should eq 2 }
      it { rbt.search { |i| i > 2 }.should eq 3 }
      it { rbt.search { |i| i > 6 }.should be_nil }
    end
  end
end
