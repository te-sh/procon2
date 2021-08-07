# :::::::::::::::::::: lib/graph/ford_fulkerson
require "lib/graph/graph"

#
# Ford-Fulkerson 法の計算結果を表します
#
class FordFulkerson(T)
  alias Node = GraphW::Node

  #
  # コンストラクタ
  # s から t への最大フローを計算します
  #
  def initialize(@g : GraphW(T), @s : Node, @t : Node)
    @adj = build_adj
    @visited = Array.new(@g.size, false)
    @flow = T.zero

    loop do
      @visited.fill(false)
      f = augment(s, @g.inf)
      break if f == 0
      @flow += f
    end
  end

  #
  # s から t への最大フローを返します
  #
  getter flow : T

  #
  # s から t への最大フローを実現するグラフを返します
  #
  def flow_graph
    g = GraphW(T).new(@g.size, @g.inf)
    @g.size.times do |i|
      @adj[i].each do |e|
        if e.flow > T.zero
          g.add_edge(e.src, e.dst, e.flow)
        end
      end
    end
    g
  end

  # ---------- private methods

  class EdgeR(T)
    def initialize(@src : Node, @dst : Node, @cap : T, @flow : T, @rev : Node)
    end

    getter src, dst, cap, rev
    property flow
  end

  def build_adj
    adj = Array.new(@g.size) { [] of EdgeR(T) }
    @g.size.times do |i|
      @g[i].each do |e|
        adj[e.src] << EdgeR.new(e.src, e.dst, e.wt, T.zero, adj[e.dst].size)
        adj[e.dst] << EdgeR.new(e.dst, e.src, T.zero, T.zero, adj[e.src].size - 1)
      end
    end
    adj
  end

  def augment(u : Node, cur : T)
    return cur if u == @t
    @visited[u] = true
    @adj[u].each do |e|
      if !@visited[e.dst] && e.cap > e.flow
        f = augment(e.dst, {e.cap - e.flow, cur}.min)
        if f > T.zero
          e.flow += f
          @adj[e.dst][e.rev].flow -= f
          return f
        end
      end
    end
    T.zero
  end

  @adj : Array(Array(EdgeR(T)))
  @visited : Array(Bool)
end

class GraphW(T)
  def ford_fulkerson(s, t)
    FordFulkerson.new(self, s, t)
  end
end
# ::::::::::::::::::::
