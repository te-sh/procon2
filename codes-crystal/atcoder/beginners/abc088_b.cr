# URL: https://atcoder.jp/contests/abs/tasks/abc088_b

def main(io)
  n = io.get_v
  a = io.get_a(n)

  a.sort! { |a, b| b <=> a }
  sa = 0.step(by: 2, to: n-1).map { |i| a[i] }.sum
  sb = 1.step(by: 2, to: n-1).map { |i| a[i] }.sum
  io.put sa - sb
end

require "lib/procon_io"

main(ProconIO.new)
