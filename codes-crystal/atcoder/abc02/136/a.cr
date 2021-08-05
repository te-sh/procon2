# URL: https://atcoder.jp/contests/abc136/tasks/abc136_a

def solve(io)
  a, b, c = io.get3
  io.put a - b >= c ? 0 : c - (a - b)
end

require "lib/procon"

solve(ProconIO.new)
