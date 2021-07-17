# URL: https://atcoder.jp/contests/sumitrust2019/tasks/sumitb2019_b

def solve(io)
  n = io.get
  x = (100 * n).cdiv(108)
  io.put 108 * x // 100 == n ? x : ":("
end

require "lib/procon"

solve(ProconIO.new)
