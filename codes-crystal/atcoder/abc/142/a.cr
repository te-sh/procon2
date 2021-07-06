# URL: https://atcoder.jp/contests/abc142/tasks/abc142_a

def main(io)
  n = io.get
  io.put n.cdiv(2) / n
end

require "lib/math/misc"

require "lib/number_ext"

require "lib/procon_io"

main(ProconIO.new)
