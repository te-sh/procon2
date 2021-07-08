# :::::::::::::::::::: lib/data_structure/cumulative_sum
#
# 累積和を表します
#
class CumulativeSum(T)
  #
  # コンストラクタ
  #
  def initialize(a : Array(T))
    @n = a.size
    @s = Array.new(@n+1, T.additive_identity)
    @n.times.each do |i|
      @s[i+1] = @s[i] + a[i]
    end
  end

  #
  # サイズを返します
  #
  getter n : Int32

  #
  # start から count 個の累積和を返します
  #
  def [](start : Int, count : Int)
    @s[start + count] - @s[start]
  end

  #
  # 区間の累積和を返します
  #
  def [](r : Range)
    sc = Indexable.range_to_index_and_count(r, @n)
    raise ArgumentError.new("Invalid range") if sc.nil?
    self[*sc]
  end

  # ---------- private methods

  @s : Array(T)
end
# ::::::::::::::::::::
