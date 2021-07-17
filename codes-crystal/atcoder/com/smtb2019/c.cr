# URL: https://atcoder.jp/contests/sumitrust2019/tasks/sumitb2019_c

def solve(io)
  x = io.get
  (1..x//100).each do |n|
    io.put_e 1 if x - 100 * n <= 5 * n
  end
  io.put 0
end

require "lib/procon"

solve(ProconIO.new)
