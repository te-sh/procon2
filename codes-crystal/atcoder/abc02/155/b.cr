# URL: https://atcoder.jp/contests/abc155/tasks/abc155_b

def solve(io)
  n = io.get
  a = io.get_a(n)
  io.put a.select(&.even?).all? { |ai| ai % 3 == 0 || ai % 5 == 0 } ? "APPROVED" : "DENIED"
end

require "lib/procon"

solve(ProconIO.new)
