# URL: https://atcoder.jp/contests/abs/tasks/arc089_a

def main(io)
  n = io.get
  t, x, y = io.get3_c(n)
  t.unshift(0)
  x.unshift(0)
  y.unshift(0)

  (0..n).each_cons_pair do |i, j|
    dt = t[j]-t[i]
    dd = (x[j]-x[i]).abs + (y[j]-y[i]).abs
    io.put_e("No") if dt < dd || dt%2 != dd%2
  end
  io.put_e("Yes")
end

require "lib/procon_io"

main(ProconIO.new)
