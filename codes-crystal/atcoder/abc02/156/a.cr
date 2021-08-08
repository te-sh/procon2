# URL: https://atcoder.jp/contests/abc156/tasks/abc156_a

def solve(io)
  n, r = io.get2
  io.put n >= 10 ? r : r + 100 * (10 - n)
end

require "lib/procon"

solve(ProconIO.new)
