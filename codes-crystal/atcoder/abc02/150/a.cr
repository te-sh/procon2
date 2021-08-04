# URL: https://atcoder.jp/contests/abc150/tasks/abc150_a

def solve(io)
  k, x = io.get2
  io.put k * 500 >= x ? "Yes" : "No"
end

require "lib/procon"

solve(ProconIO.new)
