# URL: https://atcoder.jp/contests/abc132/tasks/abc132_b

def main(io)
  n = io.get
  p = io.get_a(n)
  io.put p.each.cons(3).count { |a| a[0] < a[1] && a[1] < a[2] || a[0] > a[1] && a[1] > a[2] }
end

require "lib/procon_io"

main(ProconIO.new)
