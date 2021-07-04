require "spec"
require "../../lib/data_structure/segment_tree"

module SegmentTreeSpec
  describe SegmentTree do
    it "merge function is add" do
      s = SegmentTree(Int32).new(6) { |a, b| a + b }

      s[0] = 1
      s[2] = 2
      s[5] = 5
      s[0...0].should eq 0
      s[0...1].should eq 1
      s[..2].should eq 3
      s[...2].should eq 1
      s[2..].should eq 7

      s[2] += 1
      s[0...-3].should eq 4
      s[-4...].should eq 8
    end

    it "merge function is min" do
      s = SegmentTree(Int32).new(8, Int32::MAX) { |a, b| Math.min(a, b) }

      s[0] = 8
      s[2] = 4
      s[5] = 5
      s[0...0].should eq Int32::MAX
      s[0...1].should eq 8
      s[..2].should eq 4
      s[...2].should eq 8
      s[2..].should eq 4

      s[2] += 5
      s[0..-5].should eq 8
      s[-6...].should eq 5
    end

    it "use init array" do
      s = SegmentTree.new(Array.new(10) { |i| i+1 }) { |a, b| a + b }
      s[0...0].should eq 0
      s[0...1].should eq 1
      s[..2].should eq 6
      s[...2].should eq 3
      s[2..].should eq 52
    end
  end
end
