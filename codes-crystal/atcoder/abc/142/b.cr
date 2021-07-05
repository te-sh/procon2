# URL: https://atcoder.jp/contests/abc142/tasks/abc142_b

def main(io)
  n, k = io.get2
  h = io.get_a(n)
  io.put h.count(&.>= k)
end

require "lib/procon_io"

main(ProconIO.new)
