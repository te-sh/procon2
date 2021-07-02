# :::::::::::::::::::: lib/graph/graph
require "lib/graph/graph"
require "lib/data_structure/heap"

#
# Dijkstra 法で指定された頂点から各頂点への最短距離を計算します
#
class Dijkstra(T)
  alias Node = GraphW::Node
  alias Edge = GraphW::Edge

  #
  # コンストラクタ
  #
  def initialize(@g : GraphW(T))
    @dist = [] of T
    @prev = [] of Node
  end

  #
  # 指定された頂点から各頂点への距離を配列で返します
  #
  getter dist : Array(T)

  #
  # 計算を実行します
  #
  def run(s : Node)
    n = sent = @g.n
    @dist = Array.new(n, @g.inf)
    @dist[s] = T.new(0)
    @prev = Array.new(n, sent)

    se = Edge.new(sent, s, T.new(0))
    h = Heap.new([se]) { |a, b| a.wt <=> b.wt }
    until h.empty?
      e = h.pop

      next if @prev[e.dst] != sent
      @prev[e.dst] = e.src

      @g[e.dst].each do |f|
        w = e.wt + f.wt
        if w < @dist[f.dst]
          @dist[f.dst] = w
          h.push(Edge.new(f.src, f.dst, w))
        end
      end
    end

    self
  end
end

class GraphW(T)
  def dijkstra(s)
    Dijkstra.new(self).run(s)
  end
end
# ::::::::::::::::::::
