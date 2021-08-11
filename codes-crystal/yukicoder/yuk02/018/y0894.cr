# URL: https://yukicoder.me/problems/no/894

require "big"

def solve(io)
  t, a, b = io.get3(Int64)
  tb, ab, bb = t.to_big_i, a.to_big_i, b.to_big_i
  io.put tb.cdiv(ab) + tb.cdiv(bb) - tb.cdiv(ab.lcm(bb))
end

require "lib/procon"

solve(ProconIO.new)
