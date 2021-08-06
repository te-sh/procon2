# URL: https://atcoder.jp/contests/abc155/tasks/abc155_e

def solve(io)
  n = io.get(String)
  d = n.chars.map(&.to_i).reverse
  m = d.size

  a = Array.new(m + 1, 0)
  b = Array.new(m + 1, 0)
  b[0] = 10**9
  m.times do |i|
    a[i+1] = {a[i] + d[i], b[i] + d[i] + 1}.min
    b[i+1] = {a[i] + (10 - d[i]), b[i] + (10 - (d[i] + 1))}.min
  end

  io.put({a[m], b[m] + 1}.min)
end

require "lib/procon"

solve(ProconIO.new)
