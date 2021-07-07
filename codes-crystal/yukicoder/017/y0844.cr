# URL: https://yukicoder.me/problems/no/844

def solve(io)
  n, m, a = io.get(Int32, Int32, Int64)
  q = Array.new(m) do
    li, ri, pi = io.get(Int32, Int32, Int64); li -= 1
    Q.new(li, ri, pi)
  end

  q.sort_by! { |qi| [qi.r, qi.l] }
  dp = SegmentTree.new([0_i64] + Array.new(n, -a)) { |a, b| Math.max(a, b) }
  q.each do |qi|
    li, ri, pi = qi.l, qi.r, qi.p
    max_u(dp[ri], Math.max(dp[li]+pi-(ri == n ? 0 : a), dp[0...li]+pi-(ri == n ? a : a*2)))
  end

  io.put dp[0..n]
end

record Q, l : Int32, r : Int32, p : Int64

require "lib/data_structure/segment_tree"

require "lib/procon"

solve(ProconIO.new)
