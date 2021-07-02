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
    @b = [] of T
    @cmp = ->(a : T, b : T) { a <=> b }
  end

  #
  # コンストラクタ
  # 比較関数を指定します
  #
  def initialize(&@cmp : (T, T) -> Int32)
    @b = [] of T
  end

  #
  # コンストラクタ
  # 初期値を指定します
  # 比較関数は昇順となります
  #
  def initialize(a : Array(T))
    @b = [] of T
    @cmp = ->(a : T, b : T) { a <=> b }
    a.each do |e|
      push(e)
    end
  end

  #
  # コンストラクタ
  # 初期値を指定します
  # 比較関数を指定します
  #
  def initialize(a : Array(T), &@cmp : (T, T) -> Int32)
    @b = [] of T
    a.each do |e|
      push(e)
    end
  end

  #
  # ヒープが空かどうかを返します
  #
  delegate empty?, to: @b

  #
  # ヒープのサイズを返します
  #
  delegate size, to: @b

  #
  # 先頭の要素を返します
  #
  delegate first, to: @b

  #
  # ヒープに要素を追加します
  #
  def push(v : T)
    @b.push(v)
    i = @b.size-1
    while i > 0
      j = (i-1)//2
      break if @cmp.call(@b[j], @b[i]) < 0
      @b[j], @b[i] = @b[i], @b[j]
      j = i
    end
    self
  end

  #
  # ヒープから先頭の要素を削除してその要素を返します
  #
  def pop
    v, w = @b[0], @b.pop
    unless @b.empty?
      @b[0], i = w, 0
      while i*2+1 < @b.size
	    j = (i*2+2 >= @b.size || @cmp.call(@b[i*2+1], @b[i*2+2]) < 0) ? i*2+1 : i*2+2
        break if @cmp.call(@b[i], @b[j]) < 0
        @b[j], @b[i] = @b[i], @b[j]
        j = i
      end
    end
    v
  end
end
# ::::::::::::::::::::
