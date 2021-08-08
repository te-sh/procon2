# URL: https://atcoder.jp/contests/abc157/tasks/abc157_c

def solve(io)
  n, m = io.get2
  s, c = io.get2_c(m); s.map!(&.- 1)

  (0..999).each do |x|
    d = x.digits.reverse
    io.put_e x if d.size == n && zip(s, c).all? { |si, ci| d[si] == ci }
  end

  io.put -1
end

require "lib/procon"

solve(ProconIO.new)
