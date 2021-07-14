# :::::::::::::::::::: lib/string/rolling_hash
require "lib/data_structure/cumulative_sum"

require "lib/math/mod_int"

#
# Rolling Hash を表します
#
class RollingHash(T)
  ModInt.new_type(Mint1, 1_000_000_007)
  ModInt.new_type(Mint2,   998_244_353)

  #
  # コンストラクタ
  #
  def initialize(a : Array(T), base = random_base)
    @n = a.size

    be1 = Array.new(@n, Mint1.zero); be1[0] = Mint1.new(1)
    be2 = Array.new(@n, Mint2.zero); be2[0] = Mint2.new(1)

    (1...@n).each do |i|
      be1[i] = be1[i-1] * base
      be2[i] = be2[i-1] * base
    end

    @bi1 = Array.new(@n, Mint1.zero); @bi1[-1] = be1[-1].inv
    @bi2 = Array.new(@n, Mint2.zero); @bi2[-1] = be2[-1].inv

    (1...@n).reverse_each do |i|
      @bi1[i-1] = @bi1[i] * base
      @bi2[i-1] = @bi2[i] * base
    end

    @hc1 = CumulativeSum(Mint1).new(a.map_with_index { |e, i| be1[i] * e })
    @hc2 = CumulativeSum(Mint2).new(a.map_with_index { |e, i| be2[i] * e })
  end

  #
  # 文字列の Rolling Hash を作成します
  #
  def self.new_string(s : String, base = random_base)
    self.new(s.chars.map(&.ord), base)
  end

  #
  # 乱数で決定した base を返します
  #
  def self.random_base
    Random.rand((1 << 10)...(1 << 30))
  end

  #
  # start から count 個の Rolling Hash の値を返します
  #
  def [](start, count)
    {@hc1[start, count] * @bi1[start], @hc2[start, count] * @bi2[start]}
  end

  #
  # 区間の Rolling Hash の値を返します
  #
  def [](r : Range)
    sc = Indexable.range_to_index_and_count(r, @n)
    raise ArgumentError.new("Invalid range") if sc.nil?
    self[*sc]
  end

  # ---------- private methods

  @n : Int32
  @bi1 : Array(Mint1)
  @bi2 : Array(Mint2)
end
# ::::::::::::::::::::
