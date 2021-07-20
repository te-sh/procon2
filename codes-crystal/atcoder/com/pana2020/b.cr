# URL: https://atcoder.jp/contests/panasonic2020/tasks/panasonic2020_b

def solve(io)
  h, w = io.get2(Int64)
  io.put h == 1 || w == 1 ? 1 : (h * w).cdiv(2)
end

require "lib/procon"

solve(ProconIO.new)
