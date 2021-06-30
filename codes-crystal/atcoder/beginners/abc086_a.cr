# URL: https://atcoder.jp/contests/abs/tasks/abc086_a

def main(io)
  a, b = io.get_v(Int32, Int32)
  io.put(a%2 == 1 && b%2 == 1 ? "Odd" : "Even")
end

require "lib/procon_io"

main(ProconIO.new)
