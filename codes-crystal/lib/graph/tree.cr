# :::::::::::::::::::: lib/graph/tree
require "lib/graph/graph"

#
# 木を表します
#
class Tree
  alias Node = Graph::Node

  #
  # コンストラクタ
  # root を根とする木を作成します
  #
  def initialize(@g : Graph, @root : Node)
    n = @g.n
    @parent = Array(Node).new(n, 0)
    @depth = Array(Int32).new(n, -1)
    @dfs_order = Array(Node).new

    s = [{@root, @root}]
    until s.empty?
      u, p = s.pop

      @parent[u] = p
      @depth[u] = @depth[p] + 1
      @dfs_order << u

      @g[u].each do |v|
        s.push({v, u}) if v != p
      end
    end

    @size = Array(Int32).new(n, 1)
    @dfs_order.reverse_each do |u|
      @size[@parent[u]] += @size[u] if u != @root
    end
  end

  #
  # 根を返します
  #
  getter root : Node

  #
  # 木を DFS でたどったときの頂点の配列を返します
  #
  getter dfs_order : Array(Node)

  #
  # u の親の頂点を返します
  #
  def parent_of(u : Node)
    @parent[u]
  end

  #
  # u の深さを返します
  #
  def depth_of(u : Node)
    @depth[u]
  end

  #
  # u を根とする部分木の頂点数を返します
  #
  def size_of(u : Node)
    @size[u]
  end

  #
  # u の子を配列で返します
  #
  def children_of(u : Node)
    @g[u].reject { |v| v == @parent[u] }
  end
end

class Graph
  def tree(root)
    Tree.new(self, root)
  end
end
# ::::::::::::::::::::
