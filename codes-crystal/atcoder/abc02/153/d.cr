# URL: https://atcoder.jp/contests/abc153/tasks/abc153_d

def solve(io)
  h = io.get(Int64)
  io.put f(h)
end

def f(x)
  x == 1 ? 1_i64 : f(x // 2) * 2 + 1
end

require "lib/procon"

solve(ProconIO.new)
