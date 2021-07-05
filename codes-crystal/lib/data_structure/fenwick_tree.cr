# :::::::::::::::::::: lib/data_structure/fenwick_tree
#
# Fenwick Tree を表します
#
class FenwickTree(T)
  #
  # コンストラクタ
  #
  def initialize(@n : Int32)
    @buf = Array.new(@n+1, T.additive_identity)
  end

  #
  # インデックス i の値を返します
  #
  def [](i : Int)
    self[i..i]
  end

  #
  # 範囲 r の和を返します
  #
  def [](r : Range)
    sc = Indexable.range_to_index_and_count(r, @n)
    raise ArgumentError.new("Invalid range") if sc.nil?
    start, count = sc
    l, r = start, start + count
    get(r) - get(l)
  end

  #
  # インデックス i の値を val だけ加算します
  #
  def add(i : Int, val : T)
    i += 1
    while i <= @n
      @buf[i] += val
      i += i & -i
    end
  end

  # ---------- private methods

  @buf : Array(T)

  private def get(i : Int)
    s = T.additive_identity
    while i > 0
      s += @buf[i]
      i -= i & -i
    end
    s
  end
end
