# URL: https://atcoder.jp/contests/abc153/tasks/abc153_a

def solve(io)
  h, a = io.get2
  io.put h.cdiv(a)
end

require "lib/procon"

solve(ProconIO.new)
