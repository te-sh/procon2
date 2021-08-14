# URL: https://atcoder.jp/contests/abc130/tasks/abc130_d

def solve(io)
  n, k = io.get(Int32, Int64)
  a = io.get_a(n, Int64)

  c = CumulativeSum.new(a)

  ans = 0_i64
  n.times do |l|
    r = (l...n).bsearch { |r| c[l..r] >= k }
    ans += r.nil? ? 0 : n - r
  end

  io.put ans
end

require "lib/procon"

require "lib/data_structure/cumulative_sum"

solve(ProconIO.new)
