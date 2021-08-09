# URL: https://yukicoder.me/problems/no/760

def solve(io)
  xa, ya, ta = io.get3(Float64)
  ta *= Math::PI / 180

  x11, y11 = io.get2(Float64)
  x12, y12 = io.get2(Float64)
  x21, y21 = io.get2(Float64)
  x22, y22 = io.get2(Float64)

  tb = Math.atan2(y12-y11, x12-x11) - Math.atan2(y22-y21, x22-x21) + ta
  xb = x11 - (x21-xa) * Math.cos(tb-ta) + (y21-ya) * Math.sin(tb-ta)
  yb = y11 - (x21-xa) * Math.sin(tb-ta) - (y21-ya) * Math.cos(tb-ta)
  io.put xb, yb, tb / Math::PI * 180
end

require "lib/procon"

solve(ProconIO.new)
