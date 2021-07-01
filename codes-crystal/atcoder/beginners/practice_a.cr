# URL: https://atcoder.jp/contests/abs/tasks/practice_1

def main(io)
  a = io.get_v
  b, c = io.get_v(2)
  s = io.get_v(String)

  io.put a+b+c, s
end

require "lib/procon_io"

main(ProconIO.new)
