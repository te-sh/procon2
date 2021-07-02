# URL: https://atcoder.jp/contests/abc132/tasks/abc132_c

def main(io)
  n = io.get
  d = io.get_a(n)
  d.sort!
  io.put d[n//2]-d[n//2-1]
end

require "lib/procon_io"

main(ProconIO.new)
