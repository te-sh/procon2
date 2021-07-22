# URL: https://yukicoder.me/problems/no/857

def solve(io)
  x, y, z = io.get3(Int64)

  a = z
  a -= 1 if x <= z
  a -= 1 if y <= z

  io.put a
end

require "lib/procon"

solve(ProconIO.new)
