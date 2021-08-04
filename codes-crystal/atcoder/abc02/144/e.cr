# URL: https://atcoder.jp/contests/abc144/tasks/abc144_e

def solve(io)
  n, k = io.get(Int32, Int64)
  a = io.get_a(n, Int64)
  f = io.get_a(n, Int64)

  a.sort! { |a, b| a <=> b }
  f.sort! { |a, b| b <=> a }

  m = (0...n).max_of { |i| a[i] * f[i] }

  r = (0_i64..m).bsearch do |t|
    j = 0_i64
    zip(a, f) do |ai, fi|
      j += (ai - t // fi).clamp(0..)
    end
    j <= k
  end

  io.put r.not_nil!
end

require "lib/procon"

solve(ProconIO.new)
