# URL: https://atcoder.jp/contests/abc130/tasks/abc130_c

def solve(io)
  w, h, x, y = io.get4(Int64)
  io.put w * h / 2, x * 2 == w && y * 2 == h ? 1 : 0
end

require "lib/procon"

solve(ProconIO.new)
