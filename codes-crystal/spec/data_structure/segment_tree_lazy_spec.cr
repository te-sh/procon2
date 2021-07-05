require "spec"
require "../../lib/data_structure/segment_tree_lazy"

module SegmentTreeLazySpec
  class SegTree(T) < SegmentTreeLazy(T)
    def compose(a : T, b : T)
      a + b
    end

    def update_section(sec : Section(T), op : Op, val : T, s : Int)
      case op
      when :set
        sec.val = val * T.new(s)
        sec.laz = val
        sec.op = :set
      when :add
        sec.val += val * T.new(s)
        sec.laz = sec.op.nil? ? val : sec.laz + val
        sec.op = sec.op == :set ? :set : :add
      end
    end
  end

  describe SegmentTreeLazy do
    s = SegTree(Int32).new(7)

    it do
      s.apply(0...5, :set, 1)
      s.apply(2..6, :set, 2)
      s[0...0].should eq 0
      s[0...1].should eq 1
      s[...2].should eq 2
      s[..2].should eq 4
      s[2..].should eq 10

      s.apply(3...6, :add, 3)
      s[...3].should eq 4
      s[2..-1].should eq 19
    end
  end
end
