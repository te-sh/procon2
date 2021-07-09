require "spec"
require "lib/data_structure/red_black_tree"

module RedBlackTreeSpec
  describe RedBlackTree do
    describe "#push" do
      rbt = RedBlackTree(Int32).new

      it do
        rbt.size.should eq 0

        rbt.add(2)
        rbt.size.should eq 1
        rbt.min.should eq 2
        rbt.max.should eq 2

        rbt.add(3)
        rbt.size.should eq 2
        rbt.min.should eq 2
        rbt.max.should eq 3

        rbt.add(1)
        rbt.size.should eq 3
        rbt.min.should eq 1
        rbt.max.should eq 3

        rbt.add(1)
        rbt.size.should eq 4
        rbt.min.should eq 1
        rbt.max.should eq 3

        rbt.add(6)
        rbt.size.should eq 5
        rbt.min.should eq 1
        rbt.max.should eq 6

        rbt.add(4)
        rbt.size.should eq 6
        rbt.min.should eq 1
        rbt.max.should eq 6
      end
    end

    describe "#each and #reverse_each" do
      rbt = RedBlackTree(Int32).new
      [2, 3, 1, 1, 6, 4].each do |i|
        rbt.add(i)
      end

      it do
        a = [] of Int32
        rbt.each do |i|
          a << i
        end
        a.should eq [1, 1, 2, 3, 4, 6]

        b = [] of Int32
        rbt.reverse_each do |i|
          b << i
        end
        b.should eq [6, 4, 3, 2, 1, 1]
      end
    end

    describe "#includes? and #search" do
      rbt = RedBlackTree(Int32).new
      [2, 3, 1, 6, 4].each do |i|
        rbt.add(i)
      end

      it { rbt.includes?(3).should be_true }
      it { rbt.includes?(5).should be_false }
      it { rbt.search { |i| i >= 2 }.should eq 2 }
      it { rbt.search { |i| i > 2 }.should eq 3 }
      it { rbt.search { |i| i > 6 }.should be_nil }
    end
  end
end
