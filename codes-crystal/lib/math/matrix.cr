# :::::::::::::::::::: lib/math/matrix
require "lib/ext/number"
require "lib/math/misc"

#
# ベクトルを表します
#
class Vector(T)
  include Indexable(T)

  #
  # コンストラクタ
  # サイズを指定します
  #
  def initialize(n : Int32)
    @b = Array.new(n, T.zero)
  end

  #
  # コンストラクタ
  # 配列を指定します
  #
  def initialize(@b : Array(T))
  end

  #
  # r と一致するかどうかを返します
  #
  def ==(r : self)
    @b == r.to_a
  end

  #
  # 配列を返します
  #
  def to_a
    @b
  end

  #
  # サイズを返します
  #
  delegate size, to: @b

  #
  # i 番目の要素を返します
  #
  delegate unsafe_fetch, to: @b

  #
  # i 番目の要素を変更します
  #
  delegate :[]=, to: @b

  #
  # self + r を計算します
  #
  def +(r : self)
    raise "Size mismatch" if size != r.size
    Vector.new(@b.zip(r.to_a).map { |vi, ri| vi + ri })
  end

  #
  # self - r を計算します
  #
  def -(r : self)
    raise "Size mismatch" if size != r.size
    Vector.new(@b.zip(r.to_a).map { |vi, ri| vi - ri })
  end

  #
  # self * r を計算します
  #
  def *(r : T)
    Vector.new(@b.map { |vi| vi * r })
  end

  #
  # self と r の内積を返します
  #
  def *(r : self)
    raise "Size mismatch" if size != r.size
    @b.zip(r.to_a).map { |vi, ri| vi * ri }.sum
  end
end

#
# 行列を表します
#
class Matrix(T)
  include Indexable(T)

  #
  # コンストラクタ
  # 行数と列数を指定します
  #
  def initialize(@rows : Int32, @cols : Int32)
    @b = Array.new(@rows) { Array.new(@cols, T.zero) }
  end

  #
  # コンストラクタ
  # 配列の配列を指定します
  #
  def initialize(@b : Array(Array(T)))
    @rows = @b.size
    @cols = @b[0].size
  end

  #
  # n * n の単位行列を返します
  #
  def self.unit(n : Int32)
    new(Array.new(n) { |i| Array.new(n) { |j| i == j ? T.multiplicative_identity : T.zero } })
  end

  #
  # r と一致するかどうかを返します
  #
  def ==(r : self)
    @b == r.to_a
  end

  #
  # 配列の配列を返します
  #
  def to_a
    @b
  end

  #
  # 行数を返します
  #
  getter rows : Int32

  #
  # 列数を返します
  #
  getter cols : Int32

  #
  # 行数を返します
  #
  def size
    rows
  end

  #
  # i 行目の配列を返します
  #
  delegate unsafe_fetch, to: @b

  #
  # self + r を計算します
  #
  def +(r : self)
    raise "Size mismatch" if rows != r.rows || cols != r.cols
    Matrix.new(Array.new(rows) { |i| Array.new(cols) { |j| self[i][j] + r[i][j] } })
  end

  #
  # self - r を計算します
  #
  def -(r : self)
    raise "Size mismatch" if rows != r.rows || cols != r.cols
    Matrix.new(Array.new(rows) { |i| Array.new(cols) { |j| self[i][j] - r[i][j] } })
  end

  #
  # self * r を計算します
  #
  def *(r : T)
    Matrix.new(Array.new(rows) { |i| Array.new(cols) { |j| self[i][j] * r } })
  end

  #
  # self * r を計算します
  #
  def *(r : Vector(T))
    raise "Size mismatch" if cols != r.size
    Vector.new(Array.new(rows) { |i| (0...cols).map { |j| self[i][j] * r[j] }.sum })
  end

  #
  # self * r を計算します
  #
  def *(r : self)
    raise "Size mismatch" if cols != r.rows
    Matrix.new(Array.new(rows) { |i| Array.new(r.cols) { |j| (0...cols).map { |k| self[i][k] * r[k][j] }.sum } })
  end

  #
  # self ** r を計算します
  #
  def **(r : Int)
    raise "Size mismatch" if rows != cols
    powr(self, r, Matrix(T).unit(rows))
  end
end
# ::::::::::::::::::::
