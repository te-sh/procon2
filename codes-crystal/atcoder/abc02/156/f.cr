# URL: https://atcoder.jp/contests/abc156/tasks/abc156_f

def solve(io)
  k, q = io.get2(Int64)
  d = io.get_a(k, Int64)
  q.times do
    ni, xi, mi = io.get3(Int64)
    xi %= mi
    d2 = d.map(&.% mi)
    c = (ni - 1) // k
    al = xi + c * d2.sum + d2[0...((ni - 1) % k)].sum
    r1 = al // mi
    r2 = c * d2.count(0) + d2[0...((ni - 1) % k)].count(0)
    io.put ni - 1 - r1 - r2
  end
end

require "lib/procon"

solve(ProconIO.new)
