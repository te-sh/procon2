# :::::::::::::::::::: lib/graph/hl_decomposition
require "lib/graph/tree"

#
# HL 分解の計算結果を表します
#
class HlDecomposition
  alias Node = Graph::Node

  #
  # コンストラクタ
  # 木を HL 分解します
  #
  def initialize(@t : Tree)
    @head = Array.new(@t.size, -1)
    st = Deque{ {@t.root, @t.root} }
    until st.empty?
      u, s = st.pop
      head[u] = s
      unless @t.children[u].empty?
        z = @t.children[u].max_by { |v| @t.subtree_size[v] }
        @t.children[u].each do |v|
          st.push({v, v == z ? s : v})
        end
      end
    end
  end

  #
  # 頂点ごとにその頂点が所属するパスの最も浅い頂点を返します
  #
  getter head : Array(Node)

  #
  # LCA を返します
  #
  def lca(u : Node, v : Node)
    while @head[u] != @head[v]
      if @t.depth[@head[u]] < @t.depth[@head[v]]
        v = @t.parent[@head[v]]
      else
        u = @t.parent[@head[u]]
      end
    end
    @t.depth[u] < @t.depth[v] ? u : v
  end
end

class Tree
  def hl_decomposition
    HlDecomposition.new(self)
  end
end
# ::::::::::::::::::::
