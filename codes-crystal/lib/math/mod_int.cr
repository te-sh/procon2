# :::::::::::::::::::: lib/procon_io
require "lib/math/misc"

#
# 法を mod とする剰余群を表します
#
macro mod_int(t, m)
  struct ModInt{{m}}
    alias M = ModInt{{m}}
    MOD = {{m}}.to_i32

    #
    # コンストラクタ
    #
    def initialize(v : Int)
      @v = (v % MOD).to_i64
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
      @v == (r % MOD)
    end

    #
    # -a を返します
    #
    def - : self
      M.new(-@v)
    end

    #
    # a+r を計算します
    #
    def +(r : self)
      M.new(@v + r.v)
    end

    #
    # a+r を計算します
    #
    def +(r : Int)
      self + M.new(r)
    end

    #
    # a-r を計算します
    #
    def -(r : self)
      M.new(@v - r.v)
    end

    #
    # a-r を計算します
    #
    def -(r : Int)
      self - M.new(r)
    end

    #
    # a*r を計算します
    #
    def *(r : self)
      M.new(@v * r.v)
    end

    #
    # a*r を計算します
    #
    def *(r : Int)
      self * M.new(r)
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
      self // M.new(r)
    end

    #
    # 逆数を返します
    # m が素数でない場合は正しい値を返しません
    #
    def inv
      M.new(ext_gcd(@v.to_i32, MOD)[1])
    end
  end

  alias {{t}} = ModInt{{m}}
end
# ::::::::::::::::::::
