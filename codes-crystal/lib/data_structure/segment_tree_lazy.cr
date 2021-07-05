# :::::::::::::::::::: lib/data_structure/segment_tree
#
# 遅延伝播セグメントツリーを表します
# このクラスは継承して使われることを想定しています
# 実際の使い方は spec を参照してください
#
abstract class SegmentTreeLazy(T)
  alias Op = Symbol|Nil

  #
  # コンストラクタ
  #
  def initialize(@n : Int32, @init : T = T.zero)
    @an = 1 << (32 - (@n-1).leading_zeros_count)
    @sec = Array.new(@an*2) { Section.new(@init) }
  end

  #
  # 合成関数を表します
  #
  def compose(a : T, b : T) : T; @init; end

  #
  # セクション情報を更新します
  #
  def update_section(sec : Section, op : Op, val : T, s : Int) : NoReturn; end

  #
  # 範囲 r の合成値を返します
  #
  def [](r : Range)
    sc = Indexable.range_to_index_and_count(r, @n)
    raise ArgumentError.new("Invalid range") if sc.nil?
    start, count = sc
    l, r = start, start + count
    summary(l, r, 1, 0, @an)
  end

  #
  # 範囲 r に演算 op, 値 val を適用します
  #
  def apply(r : Range, op : Op, val : T)
    sc = Indexable.range_to_index_and_count(r, @n)
    raise ArgumentError.new("Invalid range") if sc.nil?
    start, count = sc
    l, r = start, start + count
    apply(op, val, l, r, 1, 0, @an)
  end

  #
  # セクション情報を表します
  #
  class Section(T)
    #
    # コンストラクタ
    #
    def initialize(@val : T)
      @laz = T.zero
      @op = nil
    end

    #
    # このセクションが持ってる値です.
    #
    property val : T

    #
    # 子セクションへの伝播に使う値です
    #
    property laz : T

    #
    # 子セクションへの伝播に使う演算です
    #
    property op : Symbol|Nil
  end

  # ---------- private methods

  @an : Int32
  @sec : Array(Section(T))

  private def summary(l : Int, r : Int, k : Int, nl : Int, nr : Int)
    return @init if nr <= l || r <= nl
    return @sec[k].val if l <= nl && nr <= r

    propagate(k, nl, nr)

    nm = (nl + nr) >> 1
    vl = summary(l, r,  k << 1     , nl, nm)
    vr = summary(l, r, (k << 1) | 1, nm, nr)

    compose(vl, vr)
  end

  private def propagate(k : Int, nl : Int, nr : Int)
    return if @sec[k].op.nil?

    nm = (nl + nr) >> 1
    update_section(@sec[ k << 1     ], @sec[k].op, @sec[k].laz, nm-nl)
    update_section(@sec[(k << 1) | 1], @sec[k].op, @sec[k].laz, nr-nm)

    @sec[k].op = nil
  end

  private def apply(op : Op, val : T, l : Int, r : Int, k : Int, nl : Int, nr : Int)
    return if nr <= l || r <= nl

    if l <= nl && nr <= r
      update_section(@sec[k], op, val, nr - nl)
      return
    end

    propagate(k, nl, nr)

    nm = (nl + nr) >> 1
    apply(op, val, l, r,  k << 1     , nl, nm)
    apply(op, val, l, r, (k << 1) | 1, nm, nr)

    @sec[k].val = compose(@sec[k << 1].val, @sec[(k << 1) | 1].val)
  end
end
