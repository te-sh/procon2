# URL: https://atcoder.jp/contests/abc150/tasks/abc150_c

def solve(io)
  n = io.get
  p = io.get_a(n)
  q = io.get_a(n)
  r = (1..n).to_a.permutations
  io.put (r.index(p).not_nil! - r.index(q).not_nil!).abs
end

require "lib/procon"

solve(ProconIO.new)
