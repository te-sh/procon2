# :::::::::::::::::::: lib/data_structure/heap
#
# ヒープ構造を表します
#
class Heap(T)
  #
  # コンストラクタ
  # 比較関数は昇順となります
  #
  def initialize
    initialize { |a, b| a <=> b }
  end

  #
  # コンストラクタ
  # 比較関数を指定します
  #
  def initialize(&@cmp : (T, T) -> Int32)
    dummy = uninitialized T
    @b = [dummy]
  end

  #
  # コンストラクタ
  # 初期値を指定します
  # 比較関数は昇順となります
  #
  def initialize(a : Enumerable(T))
    initialize(a) { |a, b| a <=> b }
  end

  #
  # コンストラクタ
  # 初期値を指定します
  # 比較関数を指定します
  #
  def initialize(a : Enumerable(T), &@cmp : (T, T) -> Int32)
    dummy = uninitialized T
    @b = [dummy]
    a.each do |e|
      push(e)
    end
  end

  #
  # ヒープが空かどうかを返します
  #
  def empty?
    @b.size == 1
  end

  #
  # ヒープのサイズを返します
  #
  def size
    @b.size - 1
  end

  #
  # 先頭の要素を返します
  #
  def first
    @b[1]
  end

  #
  # 先頭の要素を入れ替えます
  #
  def first=(v : T)
    @b[1], i = v, 1
    while @b.size > i << 1
      l, r = i << 1, i << 1 | 1
	  j = @b.size <= r || @cmp.call(@b[l], @b[r]) < 0 ? l : r
      break if @cmp.call(@b[i], @b[j]) < 0
      @b[j], @b[i] = @b[i], @b[j]
      i = j
    end
  end

  #
  # 要素を追加します
  #
  def push(v : T)
    @b.push(v)
    i = @b.size - 1
    while i > 1
      j = i >> 1
      break if @cmp.call(@b[j], @b[i]) < 0
      @b[j], @b[i] = @b[i], @b[j]
      i = j
    end
    self
  end

  #
  # 先頭の要素を削除してその要素を返します
  #
  def pop
    v, w = @b[1], @b.pop
    self.first = w unless empty?
    v
  end

  # ---------- private methods

  @b : Array(T)
end
# ::::::::::::::::::::
