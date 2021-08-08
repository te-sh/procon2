# :::::::::::::::::::: lib/data_structure/cumulative_sum
#
# Union-Find を表します
#
class UnionFind
  #
  # コンストラクタ
  #
  def initialize(@n : Int32)
    @s = @n
    @p = Array.new(@n, @s)
    @cf = @n
    @cn = Array.new(@n, 1)
  end

  #
  # 頂点 u と頂点 v を連結します
  #
  def unite(u : Int, v : Int)
    pu, pv = subst(u), subst(v)
    if pu != pv
      @p[pv] = pu
      @cf -= 1
      @cn[pu] += @cn[pv]
    end
    pu != pv
  end

  #
  # 頂点 u を含む連結部分の代表頂点を返します
  #
  def subst(u : Int) : Int32
    @p[u] == @s ? u.to_i32 : (@p[u] = subst(@p[u]))
  end

  #
  # 頂点 u と頂点 v が同じ連結部分にあるかどうかを返します
  #
  def same?(u : Int, v : Int)
    subst(u) == subst(v)
  end

  #
  # 連結部分の数を返します
  #
  def count_forests
    @cf
  end

  #
  # 頂点 u を含む連結部分に含まれる頂点の数を返します
  #
  def count_nodes(u : Int)
    @cn[subst(u)]
  end

  # ---------- private methods

  @p : Array(Int32)
  @cn : Array(Int32)
end
# ::::::::::::::::::::
