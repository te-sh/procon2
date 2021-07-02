# :::::::::::::::::::: lib/procon_io
require "lib/math/misc"

#
# 法を mod とする剰余群を表します
# 使用する際にはこの struct を継承して @@mod を設定します
#
abstract struct ModInt
  #
  # コンストラクタ
  #
  def initialize(v : Int)
    @v = (v % @@mod).to_i64
  end

  #
  # 内部で保持している値です
  #
  getter v : Int64

  #
  # Int32 に変換したものを返します
  #
  delegate to_i, to: @v

  #
  # 文字列に変換したものを返します
  #
  delegate to_s, to: @v

  #
  # r と一致するかどうかを返します
  #
  def ==(r : self)
    @v == r.v
  end

  #
  # r と一致するかどうかを返します
  #
  def ==(r : Int)
    @v == (r % @@mod)
  end

  #
  # -a を返します
  #
  def - : self
    m(-@v)
  end

  #
  # a+r を計算します
  #
  def +(r : self)
    m(@v + r.v)
  end

  #
  # a+r を計算します
  #
  def +(r : Int)
    self + m(r)
  end

  #
  # a-r を計算します
  #
  def -(r : self)
    m(@v - r.v)
  end

  #
  # a-r を計算します
  #
  def -(r : Int)
    self - m(r)
  end

  #
  # a*r を計算します
  #
  def *(r : self)
    m(@v * r.v)
  end

  #
  # a*r を計算します
  #
  def *(r : Int)
    self * m(r)
  end

  #
  # a//r を計算します
  #
  def //(r : self)
    self * r.inv
  end

  #
  # a//r を計算します
  #
  def //(r : Int)
    self // m(r)
  end

  #
  # 逆数を返します
  # m が素数でない場合は正しい値を返しません
  #
  def inv
    m(ext_gcd(@v.to_i32, @@mod)[1])
  end

  # ---------- private methods

  private def m(v : Int)
    self.class.new(v)
  end
end
# ::::::::::::::::::::
