# URL: https://atcoder.jp/contests/abc135/tasks/abc135_b

def solve(io)
  n = io.get
  p = io.get_a(n)
  io.put [0, 2].includes?(p.map_with_index { |pi, i| pi != i+1 }.count(true)) ? "YES" : "NO"
end

require "lib/procon"

solve(ProconIO.new)
