# URL: https://atcoder.jp/contests/sumitrust2019/tasks/sumitb2019_f

def solve(io)
  t1, t2 = io.get2(Int64)
  a1, a2 = io.get2(Int64)
  b1, b2 = io.get2(Int64)

  c1, c2 = a1 - b1, a2 - b2
  io.put_e 0 if c1 > 0 && c2 > 0 || c1 < 0 && c2 < 0
  c1, c2 = -c1, -c2 if c1 < 0

  p1 = c1 * t1
  p2 = p1 + c2 * t2

  io.put_e 0 if p2 > 0
  io.put_e "infinity" if p2 == 0

  io.put 1_i64 + (p1 % p2 == 0 ? 1 : 0) + (p1.cdiv(-p2) - 1).clamp(0..) * 2
end

require "lib/procon"

solve(ProconIO.new)
