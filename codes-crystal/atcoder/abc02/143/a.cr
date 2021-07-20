# URL: https://atcoder.jp/contests/abc143/tasks/abc143_a

def solve(io)
  a, b = io.get2
  io.put (a - b * 2).clamp(0..)
end

require "lib/procon"

solve(ProconIO.new)
