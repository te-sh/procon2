# :::::::::::::::::::: lib/graph/floyd_warshal
require "lib/graph/graph"

#
# Floyd-Warshal 法の計算結果を表します
#
class FloydWarshal(T)
  #
  # コンストラクタ
  # 任意の2頂点間の最短距離を計算します
  #
  def initialize(@g : GraphM(T))
    n = @g.size
    @dist = (0...n).map { |i| @g[i].dup }
    n.times do |k|
      n.times do |i|
        n.times do |j|
          @dist[i][j] = Math.min(@dist[i][j], @dist[i][k] + @dist[k][j])
        end
      end
    end
  end

  #
  # 任意の2頂点間の距離を行列で返します
  #
  getter dist : Array(Array(T))
end

class GraphM(T)
  def floyd_warshal
    FloydWarshal.new(self)
  end
end
# ::::::::::::::::::::
