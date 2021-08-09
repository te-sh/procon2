# :::::::::::::::::::: lib/data_structure/aa_tree
require "lib/ext/number"

#
# AA Tree を表します
#
class AATree(T)
  #
  # コンストラクタ
  #
  def initialize
    @root = NilNode(T).instance
    @size = 0
    @cmp = ->(a : T, b : T) { a <=> b }
  end

  #
  # 空かどうかを返します
  #
  def empty?
    @size == 0
  end

  #
  # サイズを返します
  #
  getter size : Int32

  #
  # key が含まれているかどうかを返します
  #
  def includes?(key : T)
    node = find_node(@root, key)
    !node.nil_node?
  end

  #
  # 最小値を返します
  #
  def min
    raise "AA Tree is empty" if empty?
    min_node(@root).key
  end

  #
  # 最大値を返します
  #
  def max
    raise "AA Tree is empty" if empty?
    max_node(@root).key
  end

  #
  # block が真になる最小の要素を返します
  # block が真になる要素がない場合は nil を返します
  # block は戻り値の要素より上にくる要素についてはすべて偽を返し, 戻り
  # 値の要素より下にくる要素についてはすべて真を返すことを想定しています
  #
  def search(&block : T -> Bool)
    node = search_node(@root, block)
    node.nil_node? ? nil : node.key
  end

  #
  # block が真になる最大の要素を返します
  # block が真になる要素がない場合は nil を返します
  # block は戻り値の要素より上にくる要素についてはすべて真を返し, 戻り
  # 値の要素より下にくる要素についてはすべて偽を返すことを想定しています
  #
  def rsearch(&block : T -> Bool)
    node = rsearch_node(@root, block)
    node.nil_node? ? nil : node.key
  end

  #
  # 要素を追加します
  #
  def insert(key : T)
    @root = insert(@root, key)
  end

  #
  # 要素を削除します
  #
  def delete(key : T)
    @root = delete(@root, key)
  end

  # ---------- private methods

  @root : Node(T)
  @cmp : (T, T) -> Int32

  private def min_node(node : Node(T))
    until node.left.nil_node?
      node = node.left
    end
    node
  end

  private def max_node(node : Node(T))
    until node.right.nil_node?
      node = node.right
    end
    node
  end

  private def find_node(node : Node(T), key : T)
    while !node.nil_node?
      c = @cmp.call(key, node.key)
      break if c.zero?
      node = c.negative? ? node.left : node.right
    end
    node
  end

  private def search_node(node : Node(T), block : T -> Bool)
    last : Node(T) = NilNode(T).instance
    loop do
      if block.call(node.key)
        last = node
        if node.left.nil_node?
          break last
        else
          node = node.left
        end
      else
        if node.right.nil_node?
          break last
        else
          node = node.right
        end
      end
    end
  end

  private def rsearch_node(node : Node(T), block : T -> Bool)
    last : Node(T) = NilNode(T).instance
    loop do
      if block.call(node.key)
        last = node
        if node.right.nil_node?
          break last
        else
          node = node.right
        end
      else
        if node.left.nil_node?
          break last
        else
          node = node.left
        end
      end
    end
  end

  private def insert(node : Node(T), key : T)
    if node.nil_node?
      @size += 1
      return Node.new(key)
    elsif @cmp.call(key, node.key).negative?
      node.left = insert(node.left, key)
    else
      node.right = insert(node.right, key)
    end
    split(skew(node))
  end

  private def delete(node : Node(T), key : T)
    unless node.nil_node?
      if @cmp.call(key, node.key).zero?
        if node.left.nil_node?
          return node.right
        elsif node.right.nil_node?
          return node.left
        else
          node.key = min_node(node.right).key
          node.right = delete(node.right, node.key)
        end
        @size -= 1
      elsif @cmp.call(key, node.key).negative?
        node.left = delete(node.left, key)
      else
        node.right = delete(node.right, key)
      end
      if node.left.height < node.height - 1 || node.right.height < node.height - 1
        node.height -= 1
        if node.right.height > node.height
          node.right.height = node.height
        end
        node = skew(node)
        node.right = skew(node.right)
        node.right.right = skew(node.right.right)
        node = split(node)
        node.right = split(node.right)
      end
    end
    node
  end

  private def skew(node : Node(T))
    if node.left.height == node.height
      node = rotate_right(node)
    end
    node
  end

  private def split(node : Node(T))
    if node.height == node.right.right.height
      node = rotate_left(node)
      node.height += 1
    end
    node
  end

  private def rotate_right(node : Node(T))
    lnode = node.left
    node.left = lnode.right
    lnode.right = node
    lnode
  end

  private def rotate_left(node : Node(T))
    rnode = node.right
    node.right = rnode.left
    rnode.left = node
    rnode
  end

  private class Node(T)
    def initialize(@key : T)
      @height = 1
      @left = NilNode(T).instance
      @right = NilNode(T).instance
    end

    property key : T
    property height : Int32
    property left : Node(T)
    property right : Node(T)

    def nil_node?
      false
    end
  end

  private class NilNode(T) < Node(T)
    def self.instance
      node = new
      node.left = node
      node.right = node
      node
    end

    def initialize
      @key = uninitialized T
      @height = 0
      @left = uninitialized Node(T)
      @right = uninitialized Node(T)
    end

    def nil_node?
      true
    end
  end
end
# ::::::::::::::::::::
