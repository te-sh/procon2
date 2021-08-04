# URL: https://atcoder.jp/contests/abc152/tasks/abc152_a

def solve(io)
  n, m = io.get2
  io.put n == m ? "Yes" : "No"
end

require "lib/procon"

solve(ProconIO.new)
