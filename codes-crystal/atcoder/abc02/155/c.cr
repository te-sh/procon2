# URL: https://atcoder.jp/contests/abc155/tasks/abc155_c

def solve(io)
  n = io.get
  h = Hash(String, Int32).new(0)
  n.times do
    si = io.get(String)
    h[si] += 1
  end
  m = h.values.max
  r = h.select { |_, v| v == m }.keys.sort
  r.each do |ri|
    io.put ri
  end
end

require "lib/procon"

solve(ProconIO.new)
