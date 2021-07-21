# :::::::::::::::::::: lib/graph/euler_tour
require "lib/graph/tree"

#
# Euler Tour の結果を表します
#
class EulerTour
  alias Node = Graph::Node

  #
  # コンストラクタ
  # 木を Euler Tour でたどります
  #
  def initialize(t : Tree)
    @path = [] of Node
    @in_time = Array.new(t.size, 0)
    @out_time = Array.new(t.size, 0)
    s = [~t.root, t.root]
    c = -1
    until s.empty?
      u = s.pop
      c += 1
      if u < 0
        @path << ~u
        @out_time[~u] = c
      else
        @path << u
        @in_time[u] = c
        children = t.children[u]
        children.each_with_index do |v, i|
          s.push(~v)
          s.push(v)
          s.push(~u) if i < children.size - 1
        end
      end
    end
  end

  #
  # Euler Tour のパスを返します
  #
  getter path : Array(Node)

  #
  # Euler Tour で u を最初に訪れた時刻を返します
  #
  getter in_time : Array(Int32)

  #
  # Euler Tour で u を最後に訪れた時刻を返します
  #
  getter out_time : Array(Int32)
end

class Tree
  def euler_tour
    EulerTour.new(self)
  end
end
# ::::::::::::::::::::
