# URL: https://atcoder.jp/contests/abc140/tasks/abc140_d

def main(io)
  n, k = io.get2
  s = io.get(String)

  b = s.chars.chunk_while { |a, b| a == b }.size
  io.put b-k*2 <= 1 ? n-1 : n-(b-k*2)
end

require "lib/procon_io"

main(ProconIO.new)
