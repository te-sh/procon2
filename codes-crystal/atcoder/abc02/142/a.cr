# URL: https://atcoder.jp/contests/abc142/tasks/abc142_a

def solve(io)
  n = io.get
  io.put n.cdiv(2) / n
end

require "lib/procon"

solve(ProconIO.new)
