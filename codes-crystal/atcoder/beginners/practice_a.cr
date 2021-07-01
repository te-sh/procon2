# URL: https://atcoder.jp/contests/abs/tasks/practice_1

def main(io)
  a = io.get
  b, c = io.get2
  s = io.get(String)

  io.put a+b+c, s
end

require "lib/procon_io"

main(ProconIO.new)
