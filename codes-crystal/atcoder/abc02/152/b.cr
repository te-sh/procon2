# URL: https://atcoder.jp/contests/abc152/tasks/abc152_b

def solve(io)
  a, b = io.get2
  io.put({a.to_s * b, b.to_s * a}.min)
end

require "lib/procon"

solve(ProconIO.new)
