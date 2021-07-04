# :::::::::::::::::::: lib/string/lcp_array
require "lib/string/suffix_array"

#
# LCP Array (最長共通接尾辞配列) を表します
#
class LcpArray
  #
  # コンストラクタ
  #
  def initialize(s : SuffixArray)
    n = s.str.size
    @x = Array.new(n, 0)
    rank = Array.new(n, 0)

    (0...n).each do |i|
      rank[s[i]] = i
    end

    h = 0
    (0...n).each do |i|
      if rank[i]+1 < n
        j = s[rank[i]+1]
        while Math.max(i, j)+h < n && s.str[i+h] == s.str[j+h]
          h += 1
        end
        @x[rank[i]+1] = h
        h -= 1 if h > 0
      end
    end
  end

  #
  # i-1 と i との LCP を返します
  #
  delegate :[], to: @x

  # ---------- private methods

  @x : Array(Int32)
end
# ::::::::::::::::::::
