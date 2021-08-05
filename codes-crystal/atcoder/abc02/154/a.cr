# URL: https://atcoder.jp/contests/abc154/tasks/abc154_a

def solve(io)
  s, t = io.get2(String)
  a, b = io.get2
  u = io.get(String)
  io.put u == s ? {a - 1, b} : {a, b - 1}
end

require "lib/procon"

solve(ProconIO.new)
