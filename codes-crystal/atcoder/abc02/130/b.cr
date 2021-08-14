# URL: https://atcoder.jp/contests/abc130/tasks/abc130_b

def solve(io)
  n, x = io.get2
  l = io.get_a(n)

  d = Array.new(n + 1, 0)
  n.times do |i|
    d[i + 1] = d[i] + l[i]
  end

  io.put d.count(&.<= x)
end

require "lib/procon"

solve(ProconIO.new)
