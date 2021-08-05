# URL: https://atcoder.jp/contests/abc136/tasks/abc136_b

def solve(io)
  n = io.get
  io.put (1..n).count { |i| i.digits.size.odd? }
end

require "lib/procon"

solve(ProconIO.new)
