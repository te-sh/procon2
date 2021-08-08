# URL: https://atcoder.jp/contests/abc156/tasks/abc156_c

def solve(io)
  n = io.get
  x = io.get_a(n)

  io.put (1..100).min_of { |i| x.map { |xi| (xi - i) ** 2 }.sum }
end

require "lib/procon"

solve(ProconIO.new)
