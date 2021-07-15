# :::::::::::::::::::: lib/data_structure/red_black_tree
require "lib/ext/number"

#
# 赤黒木を表します
#
class RedBlackTree(T)
  #
  # コンストラクタ
  #
  def initialize
    @cmp = ->(a : T, b : T) { a <=> b }
    @root = NilNode(T).instance
    @size = 0
  end

  #
  # 赤黒木が空かどうかを返します
  #
  def empty?
    @size == 1
  end

  #
  # 赤黒木のサイズを返します
  #
  getter size : Int32

  #
  # 比較関数を使用して最初にくる要素を返します
  #
  def first
    first_node(@root).key
  end

  #
  # 比較関数を使用して最後にくる要素を返します
  #
  def last
    last_node(@root).key
  end

  #
  # 比較関数を使用して最初にくる要素から順に列挙します
  #
  def each(&block : T -> _)
    x = first_node(@root)
    until x.nil_node?
      yield x.key
      x = succ_node(x)
    end
  end

  #
  # 比較関数を使用して最後にくる要素から順に列挙します
  #
  def reverse_each(&block : T -> _)
    x = last_node(@root)
    until x.nil_node?
      yield x.key
      x = pred_node(x)
    end
  end

  #
  # key が含まれているかどうかを返します
  #
  def includes?(key : T)
    x = find_node(@root, key)
    !x.nil_node?
  end

  #
  # block が真になる最小の要素を返します
  # block が真になる要素がない場合は nil を返します
  # block は戻り値の要素より上にくる要素についてはすべて偽を返し, 戻り
  # 値の要素より下にくる要素についてはすべて真を返すことを想定しています
  #
  def search(&block : T -> Bool)
    x = search_node(@root, block)
    x.nil_node? ? nil : x.key
  end

  #
  # block が真になる最大の要素を返します
  # block が真になる要素がない場合は nil を返します
  # block は戻り値の要素より上にくる要素についてはすべて真を返し, 戻り
  # 値の要素より下にくる要素についてはすべて偽を返すことを想定しています
  #
  def rsearch(&block : T -> Bool)
    x = rsearch_node(@root, block)
    x.nil_node? ? nil : x.key
  end

  #
  # 要素を追加します
  #
  def add(key : T)
    x = Node.new(key)
    insert_helper(x)

    x.color = :red
    while x != @root && x.parent.red?
      if x.parent == x.parent.parent.left
        y = x.parent.parent.right
        if !y.nil_node? && y.red?
          x.parent.color = :black
          y.color = :black
          x.parent.parent.color = :red
          x = x.parent.parent
        else
          if x == x.parent.right
            x = x.parent
            left_rotate(x)
          end
          x.parent.color = :black
          x.parent.parent.color = :red
          right_rotate(x.parent.parent)
        end
      else
        y = x.parent.parent.left
        if !y.nil_node? && y.red?
          x.parent.color = :black
          x.color = :black
          x.parent.parent.color = :red
          x = x.parent.parent
        else
          if x == x.parent.left
            x = x.parent
            right_rotate(x)
          end
          x.parent.color = :black
          x.parent.parent.color = :red
          left_rotate(x.parent.parent)
        end
      end
    end
    @root.color = :black
  end
  
  # ---------- private methods

  enum Color
    Red
    Black
  end

  class Node(T)
    def initialize(@key : T, @color : Color = :red)
      @left = NilNode(T).instance
      @right = NilNode(T).instance
      @parent = NilNode(T).instance
    end

    getter key : T
    property color : Color
    property left : Node(T)
    property right : Node(T)
    property parent : Node(T)

    delegate black?, red?, to: @color

    def nil_node?
      false
    end
  end

  class NilNode(T) < Node(T)
    def initialize
      @key = uninitialized T
      @color = :black
      @left = uninitialized Node(T)
      @right = uninitialized Node(T)
      @parent = uninitialized Node(T)
    end

    def self.instance
      instance = self.new
      instance.left = instance.right = instance.parent = instance
    end

    def nil_node?
      true
    end
  end

  @cmp : (T, T) -> Int32
  @root : Node(T)

  private def cmp(a : Node(T), b : Node(T))
    @cmp.call(a.key, b.key)
  end

  private def first_node(x : Node(T))
    until x.left.nil_node?
      x = x.left
    end
    x
  end

  private def last_node(x : Node(T))
    until x.right.nil_node?
      x = x.right
    end
    x
  end

  private def succ_node(x : Node(T))
    return first_node(x.right) unless x.right.nil_node?
    y = x.parent
    while !y.nil_node? && x == y.right
      x, y = y, y.parent
    end
    y
  end

  private def pred_node(x : Node(T))
    return last_node(x.left) unless x.left.nil_node?
    y = x.parent
    while !y.nil_node? && x == y.left
      x, y = y, y.parent
    end
    y
  end

  private def find_node(x : Node(T), key : T)
    while !x.nil_node? && x.key != key
      x = @cmp.call(key, x.key).negative? ? x.left : x.right
    end
    x
  end

  private def search_node(x : Node(T), block : T -> Bool)
    last : Node(T) = NilNode(T).instance
    loop do
      if block.call(x.key)
        last = x
        if x.left.nil_node?
          break last
        else
          x = x.left
        end
      else
        if x.right.nil_node?
          break last
        else
          x = x.right
        end
      end
    end
  end

  private def rsearch_node(x : Node(T), block : T -> Bool)
    last : Node(T) = NilNode(T).instance
    loop do
      if block.call(x.key)
        last = x
        if x.right.nil_node?
          break last
        else
          x = x.right
        end
      else
        if x.left.nil_node?
          break last
        else
          x = x.left
        end
      end
    end
  end

  private def insert_helper(z : Node(T))
    x, y = @root, NilNode(T).instance
    until x.nil_node?
      x, y = cmp(z, x).negative? ? x.left : x.right, x
    end
    z.parent = y
    if y.nil_node?
      @root = z
    else
      cmp(z, y).negative? ? y.left = z : y.right = z
    end
    @size += 1
  end

  private def left_rotate(x)
    raise "x.right is nil" if x.right.nil_node?
    y = x.right
    x.right = y.left
    y.left.parent = x unless y.left.nil_node?
    y.parent = x.parent
    if x.parent.nil_node?
      @root = y
    elsif x == x.parent.left
      x.parent.left = y
    else
      x.parent.right = y
    end
    y.left = x
    x.parent = y
  end

  private def right_rotate(x)
    raise "x.left is nil" if x.left.nil_node?
    y = x.left
    x.left = y.right
    y.parent = x.parent
    if x.parent.nil_node?
      @root = y
    elsif x == x.parent.left
      x.parent.left = y
    else
      x.parent.right = y
    end
    y.right = x
    x.parent = y
  end
end
# ::::::::::::::::::::
