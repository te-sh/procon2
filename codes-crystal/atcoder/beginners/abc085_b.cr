# URL: https://atcoder.jp/contests/abs/tasks/abc085_b

def main(io)
  n = io.get_v
  d = io.get_c(n)
  io.put d.uniq.size
end

require "lib/procon_io"

main(ProconIO.new)
