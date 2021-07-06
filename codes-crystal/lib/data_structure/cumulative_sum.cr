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
    @s = Array.new(@n+1, T.zero)
    @n.times.each do |i|
      @s[i+1] = @s[i] + a[i]
    end
  end

  #
  # サイズを返します
  #
  getter n : Int32

  #
  # 区間の累積和を返します
  #
  def [](r : Range)
    sc = Indexable.range_to_index_and_count(r, @n)
    raise ArgumentError.new("Invalid range") if sc.nil?
    start, count = sc
    @s[start + count] - @s[start]
  end

  # ---------- private methods

  @s : Array(T)
end
# ::::::::::::::::::::
