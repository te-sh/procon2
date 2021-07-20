# URL: https://atcoder.jp/contests/abc143/tasks/abc143_d

def solve(io)
  n = io.get
  l = io.get_a(n)

  l.sort!

  r = 0
  (0...n).each do |i|
    (i+1...n).each do |j|
      r += ((j+1...n).bsearch { |k| l[k] >= l[i] + l[j] } || n) - j - 1
    end
  end

  io.put r
end

require "lib/procon"

solve(ProconIO.new)
