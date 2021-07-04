# :::::::::::::::::::: lib/data_structure/segment_tree
#
# セグメントツリーを表します
#
class SegmentTree(T)
  #
  # コンストラクタ
  # init は初期値です
  #
  def initialize(@n : Int32, @init : T = T.zero, &@merge : (T, T) -> T)
    @an = Int32.new(1 << (32 - (@n-1).leading_zeros_count))
    @buf = Array(T).new(@an*2, @init)
    propagate_all
  end

  #
  # コンストラクタ
  # init は初期値です
  #
  def initialize(b : Array(T), @init : T = T.zero, &@merge : (T, T) -> T)
    @n = b.size
    @an = Int32.new(1 << (32 - (@n-1).leading_zeros_count))
    @buf = Array.new(@an*2, @init)
    @buf[@an, @n] = b
    propagate_all
  end

  #
  # インデックス i の値を返します
  #
  def [](i : Int)
    @buf[i+@an]
  end

  #
  # 範囲 r の合成値を返します
  #
  def [](r : Range)
    sc = Indexable.range_to_index_and_count(r, @n)
    raise ArgumentError.new("Invalid range") if sc.nil?
    start, count = sc
    l, r = start + @an, start + count + @an
    r1 = r2 = @init
    while l != r
      if l.odd?
        r1 = @merge.call(r1, @buf[l])
        l += 1
      end
      if r.odd?
        r -= 1
        r2 = @merge.call(@buf[r], r2)
      end
      l >>= 1
      r >>= 1
    end
    @merge.call(r1, r2)
  end

  #
  # インデックス i の値を v に変更します
  #
  def []=(i : Int, v : T)
    @buf[i+@an] = v
    propagate(i+@an)
  end

  # ---------- private methods

  private def propagate_all
    (1...@an).reverse_each do |i|
      @buf[i] = @merge.call(@buf[i*2], @buf[i*2+1])
    end
  end

  private def propagate(i : Int)
    while (i >>= 1) > 0
      @buf[i] = @merge.call(@buf[i*2], @buf[i*2+1])
    end
  end
end
# ::::::::::::::::::::
