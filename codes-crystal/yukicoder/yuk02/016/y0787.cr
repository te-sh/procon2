# URL: https://yukicoder.me/problems/no/787

def solve(io)
  p, q = io.get2(Float64); p /= 100; q /= 100
  io.put p*q / ((p*q)+(1-p)*(1-q)) * 100
end

require "lib/procon"

solve(ProconIO.new)
