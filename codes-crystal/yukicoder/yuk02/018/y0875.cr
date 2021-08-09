# URL: https://yukicoder.me/problems/no/875

def solve(io)
  n, q = io.get2
  a = io.get_a(n); a.map!(&.- 1)

  b = Array.new(n, 0)
  a.each_with_index do |ai, i|
    b[ai] = i
  end

  s = SegmentTree.new(a, n) { |a, b| {a, b}.min }

  q.times do
    t, l, r = io.get3; l -= 1; r -= 1
    case t
    when 1
      b[s[l]], b[s[r]] = b[s[r]], b[s[l]]
      s[l], s[r] = s[r], s[l]
    when 2
      io.put b[s[l..r]] + 1
    end
  end
end

require "lib/procon"

require "lib/data_structure/segment_tree"

solve(ProconIO.new)
