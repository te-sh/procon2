# URL: https://atcoder.jp/contests/abc154/tasks/abc154_c

def solve(io)
  n = io.get
  a = io.get_a(n)
  io.put a.size == a.uniq.size ? "YES" : "NO"
end

require "lib/procon"

solve(ProconIO.new)
