# :::::::::::::::::::: lib/math/mod_int
require "lib/math/misc"

#
# 法を mod とする剰余群を表します
# 使用する際にはこの struct を継承して @@mod を設定します
#
abstract struct ModInt < Number
  #
  # 法を mod とする剰余群の struct を名前 name で定義します
  #
  macro new_type(name, mod)
    struct {{name}} < ModInt
      @@mod : Int32 = {{mod}}
    end
  end

  #
  # コンストラクタ
  #
  def initialize(v : Int)
    @v = (v % @@mod).to_i64
  end

  #
  # オブジェクトのハッシュを返します
  #
  def_hash @@mod, @v

  #
  #
  # 文字列に変換したものを返します
  #
  def to_s
    @v.to_s
  end

  #
  # 文字列に変換したものを io に追加します
  #
  def to_s(io : IO) : Nil
    @v.to_s(io)
  end

  # 内部で保持している値です
  #
  getter v : Int64

  #
  # Int32 に変換したものを返します
  #
  delegate to_i, to: @v

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
  # a**n を計算します
  #
  def **(n : Int)
    powr(self, n)
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
