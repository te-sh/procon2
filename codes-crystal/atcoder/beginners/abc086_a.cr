# URL: https://atcoder.jp/contests/abs/tasks/abc086_a

def main(io)
  a, b = io.get2
  io.put a.odd? && b.odd? ? "Odd" : "Even"
end

require "lib/procon_io"

main(ProconIO.new)
