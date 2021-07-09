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
  # 最小の要素を返します
  #
  def min
    min_node(@root).key
  end

  #
  # 最大の要素を返します
  #
  def max
    max_node(@root).key
  end

  #
  # 要素が含まれているかどうかを返します
  #
  def includes?(key : T)
    x = find_node(@root, key)
    !x.nil_node?
  end

  #
  # block が真になる最小の要素を返します
  # block はその要素より小さい要素についてはすべて false を返し,
  # その要素より大きい要素についてはすべて true を返すことを想定しています
  #
  def search(&block : T -> Bool)
    x = search_node(@root, block)
    x.nil_node? ? nil : x.key
  end

  #
  # 要素を追加します
  #
  def push(key : T)
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

  private def cmp(a : Node, b : Node)
    @cmp.call(a.key, b.key)
  end

  private def min_node(x : Node)
    until x.left.nil_node?
      x = x.left
    end
    x
  end

  private def max_node(x : Node)
    until x.right.nil_node?
      x = x.right
    end
    x
  end

  private def find_node(x : Node, key : T)
    while !x.nil_node? && x.key != key
      x = @cmp.call(key, x.key).negative? ? x.left : x.right
    end
    x
  end

  private def search_node(x : Node, block : T -> Bool)
    last : Node(T) = NilNode(T).instance
    loop do
      if block.call(x.key)
        last = x
        if x.left.nil_node?
          return last
        else
          x = x.left
        end
      else
        if x.right.nil_node?
          return last
        else
          x = x.right
        end
      end
    end
  end

  private def insert_helper(z : Node)
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
