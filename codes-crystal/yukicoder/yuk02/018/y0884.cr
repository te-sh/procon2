# URL: https://yukicoder.me/problems/no/884

def solve(io)
  n = io.get(String)
  d = n.chars.map(&.to_i)
  m = d.size

  a = Array.new(m + 1, 0)
  b = Array.new(m + 1, 0)
  b[0] = 10 ** 9

  m.times do |i|
    a[i + 1] = {a[i] + d[i], b[i] + d[i] + 1}.min
    b[i + 1] = {a[i] + (2 - d[i]), b[i] + (2 - (d[i] + 1))}.min
  end

  io.put({a[m], b[m] + 1}.min)
end

require "lib/procon"

solve(ProconIO.new)
