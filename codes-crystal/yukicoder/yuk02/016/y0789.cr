# URL: https://yukicoder.me/problems/no/789

def solve(io)
  n = io.get
  t, a, b = io.get3_c(n)

  c = [] of Int32
  zip(t, a, b) do |ti, ai, bi|
    c << ai
    c << bi if ti == 1
  end

  za = Zaatsu.new(c)

  s = SegmentTree(Int32).new(za.size) { |a, b| a + b }
  ans = 0_i64
  zip(t, a, b) do |ti, ai, bi|
    if ti == 0
      s[za.comp(ai)] += bi
    else
      ans += s[za.comp(ai)..za.comp(bi)]
    end
  end

  io.put ans
end

require "lib/procon"

require "lib/data_structure/zaatsu"

require "lib/data_structure/segment_tree"

solve(ProconIO.new)
