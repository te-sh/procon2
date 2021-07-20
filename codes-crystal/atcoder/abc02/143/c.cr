# URL: https://atcoder.jp/contests/abc143/tasks/abc143_c

def solve(io)
  n = io.get
  s = io.get(String)
  io.put s.each_char.chunk_while { |a, b| a == b }.size
end

require "lib/procon"

solve(ProconIO.new)
