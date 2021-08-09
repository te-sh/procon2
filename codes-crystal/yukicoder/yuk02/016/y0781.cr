# URL: https://yukicoder.me/problems/no/781

def solve(io)
  x, y = io.get2

  c = Array.new(y+1, 0)
  (0..Math.isqrt(y)).each do |i|
    (1..Math.isqrt(y)).each do |j|
      r = i**2 + j**2
      c[r] += 1 if r <= y
    end
  end

  io.put c[x..y].max * 4
end

require "lib/procon"

solve(ProconIO.new)
