# URL: https://atcoder.jp/contests/abc150/tasks/abc150_b

def solve(io)
  n = io.get
  s = io.get(String)
  io.put s.scan("ABC").size
end

require "lib/procon"

solve(ProconIO.new)
