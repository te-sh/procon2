# URL: https://yukicoder.me/problems/no/773

def solve(io)
  a, b = io.get2

  c = 3
  (a..b).each do |i|
    c -= 1 if (23..25).includes?(i)
  end

  io.put c
end

require "lib/procon"

solve(ProconIO.new)
