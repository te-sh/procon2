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
    size = @g.size
    @parent = Array.new(size, 0)
    @children = Array.new(size) { [] of Node }
    @depth = Array.new(size, -1)
    @dfs_order = [] of Node

    s = [{@root, @root}]
    until s.empty?
      u, p = s.pop

      @parent[u] = p
      @depth[u] = @depth[p] + 1
      @dfs_order << u

      @g[u].each do |v|
        if v != p
          @children[u] << v
          s.push({v, u})
        end
      end
    end

    @descendant_size = Array.new(size, 1)
    @dfs_order.reverse_each do |u|
      @descendant_size[@parent[u]] += @descendant_size[u] if u != @root
    end
  end

  #
  # 頂点数を返します
  #
  delegate size, to: @g

  #
  # 根を返します
  #
  getter root : Node

  #
  # 木を DFS でたどったときの頂点の配列を返します
  #
  getter dfs_order : Array(Node)

  #
  # 親の頂点の配列を返します
  #
  getter parent : Array(Node)

  #
  # 子の頂点を配列の配列で返します
  #
  getter children : Array(Array(Node))

  #
  # 頂点深さを配列で返します
  #
  getter depth : Array(Int32)

  #
  # 部分木の頂点数を配列で返します
  #
  getter descendant_size : Array(Int32)
end

class Graph
  def tree(root)
    Tree.new(self, root)
  end
end
# ::::::::::::::::::::
