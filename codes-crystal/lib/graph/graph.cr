# :::::::::::::::::::: lib/graph/graph
#
# グラフを表します
# 辺は隣接リスト構造を持ち, 重みは管理しません
#
class Graph
  alias Node = Int32
  alias Nodes = Array(Node)
  getter n : Node

  #
  # コンストラクタ
  #
  def initialize(@n : Node)
    @g = Array(Nodes).new(@n) { [] of Node }
  end

  delegate :[], to: @g

  #
  # 頂点 u から頂点 v への有向辺を追加します
  #
  def add_edge(u : Node, v : Node)
    @g[u] << v
  end

  #
  # 頂点 u から頂点 v への有向辺および頂点 v から頂点 u への有向辺を追加します
  #
  def add_edge_b(u : Node, v : Node)
    @g[u] << v
    @g[v] << u
  end
end
# ::::::::::::::::::::
