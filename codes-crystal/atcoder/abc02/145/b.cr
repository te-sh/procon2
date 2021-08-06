# URL: https://atcoder.jp/contests/abc145/tasks/abc145_b

def solve(io)
  n = io.get
  s = io.get(String)
  io.put n.even? && s[...n // 2] == s[n // 2...] ? "Yes" : "No"
end

require "lib/procon"

solve(ProconIO.new)
