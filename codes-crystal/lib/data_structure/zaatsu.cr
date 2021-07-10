# :::::::::::::::::::: lib/data_structure/zaatsu
#
# 座標圧縮/展開を行います
#
class Zaatsu(T)
  #
  # コンストラクタ
  #
  def initialize(*v : Array(T))
    @c1 = Hash(T, Int32).new
    v.each do |w|
      w.each do |e|
        @c1[e] = 0
      end
    end
    @size = @c1.size
    @c2 = Array(T).new(@size)
    @c1.keys.sort.each_with_index do |k, i|
      @c1[k] = i
      @c2 << k
    end
  end

  #
  # 圧縮された座標の種類数を返します
  #
  getter size : Int32

  #
  # 座標圧縮した値を返します
  #
  def comp(v : T)
    @c1[v]
  end

  #
  # 座標圧縮を元に戻した値を返します
  #
  def uncomp(v : Int)
    @c2[v]
  end

  # ---------- private methods

  @c1 : Hash(T, Int32)
  @c2 : Array(T)
end
# ::::::::::::::::::::
