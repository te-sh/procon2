# :::::::::::::::::::: lib/graph/dinic
require "lib/graph/graph"

#
# Dinic 法の計算結果を表します
#
class Dinic(T)
  alias Node = GraphW::Node

  #
  # コンストラクタ
  # s から t への最大フローを計算します
  #
  def initialize(@g : GraphW(T), @s : Node, @t : Node)
    @adj = build_adj
    @level = Array.new(@g.size, 0)
    @flow = T.zero

    while levelize >= 0
      iter = @adj.map(&.each)
      while (f = augment(iter, @s, @g.inf)) > 0
        @flow += f
      end
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

  def levelize
    @level.fill(-1)
    @level[@s] = 0

    q = Deque(Node){@s}
    until q.empty?
      u = q.shift
      break if u == @t
      @adj[u].each do |e|
        if e.cap > e.flow && @level[e.dst] < 0
          q.push(e.dst)
          @level[e.dst] = @level[u] + 1
        end
      end
    end

    @level[@t]
  end

  def augment(iter, u : Node, cur : T)
    return cur if u == @t

    iter[u].each do |e|
      r = @adj[e.dst][e.rev]
      if e.cap > e.flow && @level[u] < @level[e.dst]
        f = augment(iter, e.dst, {e.cap - e.flow, cur}.min)
        if f > 0
          e.flow += f
          r.flow -= f
          return f
        end
      end
    end

    T.zero
  end

  @adj : Array(Array(EdgeR(T)))
  @level : Array(Int32)
end

class GraphW(T)
  def dinic(s, t)
    Dinic.new(self, s, t)
  end
end
# ::::::::::::::::::::
