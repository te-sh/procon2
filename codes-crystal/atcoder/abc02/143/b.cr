# URL: https://atcoder.jp/contests/abc143/tasks/abc143_b

def solve(io)
  n = io.get
  d = io.get_a(n)

  r = 0
  (0...n).each do |i|
    (i+1...n).each do |j|
      r += d[i] * d[j]
    end
  end

  io.put r
end

require "lib/procon"

solve(ProconIO.new)
