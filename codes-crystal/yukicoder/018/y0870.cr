# URL: https://yukicoder.me/problems/no/870

def solve(io)
  b = Array.new_md(10, 10, 0)
  b[2][8] = 1
  b[3][9] = 2
  b[7][9] = 3

  n = io.get
  n.times do
    x1, y1, x2, y2 = io.get4
    b[x2][y2], b[x1][y1] = b[x1][y1], 0
  end

  io.put b[5][8] == 1 && b[4][8] == 2 && b[6][8] == 3 ? "YES" : "NO"
end

require "lib/procon"

solve(ProconIO.new)
