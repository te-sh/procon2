# URL: https://atcoder.jp/contests/abc154/tasks/abc154_d

def solve(io)
  n, k = io.get2
  p = io.get_a(n)
  q = p.map { |pi| (pi + 1) / 2 }
  cq = CumulativeSum.new(q)
  io.put (0..(n - k)).max_of { |i| cq[i, k] }
end

require "lib/procon"

require "lib/data_structure/cumulative_sum"

solve(ProconIO.new)
