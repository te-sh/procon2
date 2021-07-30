require "spec"
require "lib/data_structure/segment_tree_lazy"

module SegmentTreeLazySpec
  class SegTree < SegmentTreeLazy(Int32)
    class OpSet < Op
      def initialize(@val : Int32); end
      getter val : Int32
    end

    class OpAdd < Op
      def initialize(@val : Int32); end
      getter val : Int32
    end

    def compose(a : Int32, b : Int32)
      a + b
    end

    def update_section(sec : Section(Int32), op : Op, s : Int)
      case op
      when OpSet
        sec.val = op.val * s
        sec.op = op
      when OpAdd
        sec.val += op.val * s
        sec.op = case prev = sec.op
                 when OpSet
                   OpSet.new(prev.val + op.val)
                 when OpAdd
                   OpAdd.new(prev.val + op.val)
                 else
                   op
                 end
      end
    end
  end

  describe SegmentTreeLazy do
    it "initialize with no array" do
      s = SegTree.new(7)

      s.apply(0...5, SegTree::OpSet.new(1))
      s.apply(2..6, SegTree::OpSet.new(2))
      s[0...0].should eq 0
      s[0...1].should eq 1
      s[...2].should eq 2
      s[..2].should eq 4
      s[1, 4].should eq 7
      s[2..].should eq 10

      s.apply(3...6, SegTree::OpAdd.new(3))
      s[...3].should eq 4
      s[2, 3].should eq 12
      s[2..-1].should eq 19
    end

    it "initialize with array" do
      s = SegTree.new([1, 5, 3, 2, 6])
      s[0..2].should eq 9

      s.apply(1..3, SegTree::OpSet.new(4))
      s[3..].should eq 10

      s.apply(0..1, SegTree::OpAdd.new(2))
      s[..2].should eq 13
    end
  end
end
