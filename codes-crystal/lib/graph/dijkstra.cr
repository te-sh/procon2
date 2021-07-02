# :::::::::::::::::::: lib/graph/graph
require "lih/graph/graph"
require "lib/data_straucture/heap"

#
# Dijkstra 法で指定された頂点から各頂点への最短距離を計算します
#
class Dijkstra(T)
  alias Graph = GraphW(T)
  alias Node = Graph::Node
  alias Edge = Graph::Edge

  #
  # コンストラクタ
  #
  def initialize(@g : Graph)
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
    @dist = Array(T).new(n, @g.inf)
    @prev = Array(Node).new(n, sent)

    @dist[s] = T.new(0)
    h = Heap(Edge).new([Edge.new(sent, s, T.new(0))])
    until h.empty?
      e = h.pop

      next if prev[e.dst] != sent
      prev[e.dst] = e.src

      @g[e.dst].each do |f|
        w = e.wt + f.wt
        if @dist[f.dst] > w
          dist[f.dst] = w
          h.push(Edge.new(f.src, f.dst, w))
        end
      end
    end
  end
end

class GraphW(T)
  def dijkstra(Node s)
    Dijkstra(T).new.run(s)
  end
end
# ::::::::::::::::::::
