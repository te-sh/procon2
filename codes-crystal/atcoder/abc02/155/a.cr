# URL: https://atcoder.jp/contests/abc155/tasks/abc155_a

def solve(io)
  a = io.get_a(3)
  io.put a.uniq.size == 2 ? "Yes" : "No"
end

require "lib/procon"

solve(ProconIO.new)
