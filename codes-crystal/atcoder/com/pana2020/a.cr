# URL: https://atcoder.jp/contests/panasonic2020/tasks/panasonic2020_a

A = [1, 1, 1, 2, 1, 2, 1, 5, 2, 2, 1, 5, 1, 2, 1, 14, 1, 5, 1, 5, 2, 2, 1, 15, 2, 2, 5, 4, 1, 4, 1, 51]

def solve(io)
  k = io.get
  io.put A[k-1]
end

require "lib/procon"

solve(ProconIO.new)
