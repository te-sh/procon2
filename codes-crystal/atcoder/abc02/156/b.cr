# URL: https://atcoder.jp/contests/abc156/tasks/abc156_b

def solve(io)
  n, k = io.get2
  io.put n.to_s(k).size
end

require "lib/procon"

solve(ProconIO.new)
