# URL: https://yukicoder.me/problems/no/785

def solve(io)
  c = io.get_c(3, String)
  io.put c.map { |ci| ci == "NONE" ? 0 : ci.size.cdiv(2) }.map { |ci| (16 - ci) ** 2 }.product
end

require "lib/procon"

solve(ProconIO.new)
