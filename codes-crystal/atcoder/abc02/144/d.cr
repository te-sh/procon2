# URL: https://atcoder.jp/contests/abc144/tasks/abc144_d

def solve(io)
  a, b, x = io.get3(Float64)
  y = x / a

  if y <= a * b / 2
    io.put Math.atan2(b * b, y * 2) / Math::PI * 180
  else
    z = a * b - y
    io.put Math.atan2(z * 2, a * a) / Math::PI * 180
  end
end

require "lib/procon"

solve(ProconIO.new)
