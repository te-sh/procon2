# :::::::::::::::::::: lib/data_structure/sparse_table
require "lib/ext/array"

#
# Sparse Table を表します
#
class SparseTable(T)
  #
  # コンストラクタ
  #
  def initialize(@a : Array(T), &@compose : (T, T) -> T)
    @n = @a.size

    @log_table = Array.new(@n+1, 0)
    (2..@n).each do |i|
      @log_table[i] = @log_table[i >> 1] + 1
    end

    @rmq = Array.new_md(@log_table[@n] + 1, @n, 0)
    @n.times do |i|
      @rmq[0][i] = i
    end

    k = 1
    while (1 << k) < @n
      i = 0
      while i + (1 << k) <= @n
        x = @rmq[k-1][i]
        y = @rmq[k-1][i + (1 << k-1)]
        @rmq[k][i] = @compose.call(@a[x], @a[y]) == @a[x] ? x : y
        i += 1
      end
      k += 1
    end
  end

  #
  # 範囲 r の合成値を返します
  #
  def [](r : Range)
    sc = Indexable.range_to_index_and_count(r, @n)
    raise ArgumentError.new("Invalid range") if sc.nil?
    start, count = sc
    l, r = start, start + count
    k = @log_table[r - l - 1]
    x = @rmq[k][l]
    y = @rmq[k][r - (1 << k)]
    @compose.call(@a[x], @a[y])
  end

  # ---------- private methods

  @n : Int32
  @log_table : Array(Int32)
  @rmq : Array(Array(Int32))
end
# ::::::::::::::::::::
