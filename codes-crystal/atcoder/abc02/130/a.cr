# URL: https://atcoder.jp/contests/abc130/tasks/abc130_a

def solve(io)
  x, a = io.get2
  io.put x < a ? 0 : 10
end

require "lib/procon"

solve(ProconIO.new)
