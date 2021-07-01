# URL: https://atcoder.jp/contests/abc131/tasks/abc131_c

def main(io)
  a, b, c, d = io.get4(Int64)

  g = c.gcd(d)
  e = c//g*d
  na = (a-1)//c + (a-1)//d - (a-1)//e
  nb = b//c + b//d - b//e

  io.put b-a+1-(nb-na)
end

require "lib/procon_io"

main(ProconIO.new)
