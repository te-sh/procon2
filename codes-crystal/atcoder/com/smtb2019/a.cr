# URL: https://atcoder.jp/contests/sumitrust2019/tasks/sumitb2019_a

def solve(io)
  m1, d1 = io.get2
  m2, d2 = io.get2
  io.put m1 != m2 ? 1 : 0
end

require "lib/procon"

solve(ProconIO.new)
