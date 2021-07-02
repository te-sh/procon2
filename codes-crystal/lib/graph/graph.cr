# :::::::::::::::::::: lib/graph/graph
#
# グラフを表します
# 辺は隣接リスト構造を持ち, 重みは管理しません
#
class Graph
  alias Node = Int32
  alias Nodes = Array(Node)

  #
  # コンストラクタ
  #
  def initialize(@n : Node)
    @g = Array(Nodes).new(@n) { [] of Node }
  end

  #
  # 頂点数を返します
  #
  getter n : Node

  #
  # i 番目の頂点リストを返します
  #
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

#
# グラフを表します
# 辺は隣接リスト構造を持ち, 重みを管理します
#
class GraphW(T)
  alias Node = Int32
  alias Edges = Array(Edge)

  #
  # 辺を表します
  #
  struct Edge
    #
    # コンストラクタ
    #
    def initialize(@src : Node, @dst : Node, @wt : T)
    end

    #
    # 辺の始点および終点を返します
    #
    getter src : Node, dst : Node

    #
    # 辺の重みを返します
    #
    getter wt : T
  end
      
  #
  # コンストラクタ
  # inf は無限大の代用です
  #
  def initialize(@n : Node, @inf = 10**9)
    @g = Array(Edges).new(@n) { [] of Edge }
  end

  #
  # 頂点数を返します
  #
  getter n : Node

  #
  # i 番目の辺リストを返します
  #
  delegate :[], to: @g

  #
  # 頂点 u から頂点 v への重み wt の有向辺を追加します
  #
  def add_edge(u : Node, v : Node, wt : T)
    @g[u] << Edge.new(u, v, wt)
  end

  #
  # 頂点 u から頂点 v への重み wt の有向辺および頂点 v から頂点 u への重み wt の有向辺を追加します
  #
  def add_edge_b(u : Node, v : Node, wt : T)
    @g[u] << Edge.new(u, v, wt)
    @g[v] << Edge.new(v, u, wt)
  end
end
# ::::::::::::::::::::
