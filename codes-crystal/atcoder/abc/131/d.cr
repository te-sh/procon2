# URL: https://atcoder.jp/contests/abc131/tasks/abc131_d

def solve(io)
  n = io.get
  a, b = io.get2_c(n)
  t = Array.new(n) { |i| T.new(a[i], b[i]) }
  t.sort! { |a, b| a.b <=> b.b }

  s = 0
  t.each do |ti|
    s += ti.a
    io.put_e "No" if s > ti.b
  end
  io.put "Yes"
end

record T, a : Int32, b : Int32

require "lib/procon"

solve(ProconIO.new)
