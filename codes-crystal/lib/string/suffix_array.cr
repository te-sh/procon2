# :::::::::::::::::::: lib/string/suffix_array
#
# Suffix Array を表します
#
class SuffixArray
  #
  # コンストラクタ
  #
  def initialize(@str : String)
    n = @str.size
    @x = Array.new(n, 0)
    r = Array.new(n, 0)
    t = Array.new(n, 0)

    (0...n).each do |i|
      @x[i] = i
      r[@x[i]] = @str[i].ord
    end

    h = 1
    while t[n-1] != n-1
      cmp = ->(i : Int32, j : Int32) {
        if r[i] != r[j]
          r[i] <=> r[j]
        elsif i+h < n && j+h < n
          r[i+h] <=> r[j+h]
        else
          j <=> i
        end
      }
      @x.sort!(&cmp)

      (0...n-1).each do |i|
        t[i+1] = t[i] + (cmp.call(@x[i], @x[i+1]) < 0 ? 1 : 0)
      end

      (0...n).each do |i|
        r[@x[i]] = t[i]
      end

      h <<= 1
    end
  end

  #
  # Suffix Array 作成に使用した文字列を返します
  #
  getter str : String

  #
  # i 番目の接尾辞の位置を返します
  #
  delegate :[], to: @x

  # ---------- private methods

  @x : Array(Int32)
end
# ::::::::::::::::::::
