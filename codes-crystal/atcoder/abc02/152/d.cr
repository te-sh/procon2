# URL: https://atcoder.jp/contests/abc152/tasks/abc152_d

def solve(io)
  n = io.get

  t = Array.new_md(10, 10, 0)
  (1..n).each do |i|
    d = i.digits
    t[d[0]][d[-1]] += 1 unless d[-1] == 0
  end

  r = 0_i64
  (1..n).each do |i|
    d = i.digits
    r += t[d[-1]][d[0]]
  end

  io.put r
end

require "lib/procon"

solve(ProconIO.new)
