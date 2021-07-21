# :::::::::::::::::::: lib/data_structure/fenwick_tree
#
# Fenwick Tree を表します
#
class FenwickTree(T)
  #
  # コンストラクタ
  #
  def initialize(@n : Int32)
    @b = Array.new(@n + 1, T.additive_identity)
  end

  #
  # インデックス i の値を返します
  #
  def [](i : Int)
    self[i..i]
  end

  #
  # start から count 個の和を返します
  #
  def [](start : Int, count : Int)
    get(start + count) - get(start)
  end

  #
  # 範囲 r の和を返します
  #
  def [](r : Range)
    sc = Indexable.range_to_index_and_count(r, @n)
    raise ArgumentError.new("Invalid range") if sc.nil?
    self[*sc]
  end

  #
  # インデックス i の値を val だけ加算します
  #
  def add(i : Int, val : T)
    i += 1
    while i <= @n
      @b[i] += val
      i += i & -i
    end
  end

  # ---------- private methods

  @b : Array(T)

  private def get(i : Int)
    s = T.additive_identity
    while i > 0
      s += @b[i]
      i -= i & -i
    end
    s
  end
end
# ::::::::::::::::::::
