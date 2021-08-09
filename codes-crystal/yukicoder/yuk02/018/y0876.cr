# URL: https://yukicoder.me/problems/no/876

def solve(io)
  n, q = io.get2
  a = io.get_a(n, Int64)

  s = SegTree.new(a.map { |ai| Item.new(ai, ai, 1) }, Item.new(-1, -1, 0))
  q.times do
    case io.get
    when 1
      l, r, x = io.get(Int32, Int32, Int64); l -= 1; r -= 1
      s.apply(l..r, SegTree::OpAdd.new(x))
    when 2
      l, r = io.get2; l -= 1; r -= 1
      io.put s[l..r].b
    end
  end
end

record Item, l : Int64, r : Int64, b : Int32

require "lib/procon"

require "lib/data_structure/segment_tree_lazy"

class SegTree < SegmentTreeLazy(Item)
  class OpAdd < Op
    def initialize(@val : Int64); end
    getter val : Int64
  end

  def compose(a : Item, b : Item)
    if b.l == -1
      a
    elsif a.l == -1
      b
    else
      Item.new(a.l, b.r, a.b + b.b - (a.r == b.l ? 1 : 0))
    end
  end

  def update_section(sec : Section(Item), op : Op, s : Int) forall U
    return if sec.val.l == -1
    case op
    when OpAdd
      sec.val = Item.new(sec.val.l + op.val, sec.val.r + op.val, sec.val.b)
      sec.op = case prev = sec.op
               when OpAdd
                 OpAdd.new(prev.val + op.val)
               else
                 op
               end
    end
  end
end

solve(ProconIO.new)
