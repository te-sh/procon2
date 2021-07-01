# URL: https://atcoder.jp/contests/abc131/tasks/abc131_b

def main(io)
  n, l = io.get2
  t = Array.new(n) { |i| l+i }

  m = 1000
  t.each do |ti|
    m = ti if ti.abs < m.abs
  end

  io.put t.sum - m
end

require "lib/procon_io"

main(ProconIO.new)
