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
    @s = Array(T).new(@n+1, T.new(0))
    (0...@n).each do |i|
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
    b = r.begin
    b = if b.nil?
          0
        elsif b < 0
          @n + b
        else
          b
        end

    e = r.end
    e = if e.nil?
          @n
        elsif e < 0
          r.excludes_end? ? @n + e : @n + e + 1
        else
          r.excludes_end? ? e : e + 1
        end

    @s[e] - @s[b]
  end
end
