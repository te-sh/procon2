# URL: https://atcoder.jp/contests/abc134/tasks/abc134_b

def solve(io)
  n, d = io.get2
  io.put n.cdiv(d*2+1)
end

require "lib/procon"

solve(ProconIO.new)
