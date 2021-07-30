# :::::::::::::::::::: lib/math/vector
#
# ベクトルを表します
#
class Vector(T)
  include Indexable(T)
  delegate size, unsafe_fetch, :[]=, to: @b

  #
  # コンストラクタ
  #
  def initialize(@b : Array(T))
  end

  #
  # a+r を返します
  #
  def +(r : Vector(T))
    raise "Mismatch size" if size != r.size
    Vector(T).new(Array.new(size) { |i| self[i] + r[i] })
  end

  #
  # a-r を返します
  #
  def -(r : Vector(T))
    raise "Mismatch size" if size != r.size
    Vector(T).new(Array.new(size) { |i| self[i] - r[i] })
  end
end
# ::::::::::::::::::::
