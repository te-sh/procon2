# URL: https://yukicoder.me/problems/no/1644

def solve(io)
  k = io.get
  r = 0
  (1..8).to_a.each_permutation(8) do |i|
    r += 1 if i.join.to_i % k == 0
  end
  io.put r
end

require "lib/procon"

solve(ProconIO.new)
