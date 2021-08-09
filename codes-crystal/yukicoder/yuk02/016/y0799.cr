# URL: https://yukicoder.me/problems/no/799

def solve(io)
  a, b, c, d = io.get4

  r = 0
  (a..b).each do |i|
    (c..d).each do |j|
      r += 1 if i != j
    end
  end

  io.put r
end

require "lib/procon"

solve(ProconIO.new)
