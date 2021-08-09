# URL: https://yukicoder.me/problems/no/858

def solve(io)
  a, b = io.get2(Int64)

  c = a // b
  d = a % b
  e = [] of Int64
  50.times do
    e << d * 10 // b
    d = d * 10 % b
  end

  io.put c, ".", e, delimiter: ""
end

require "lib/procon"

solve(ProconIO.new)
