# URL: https://atcoder.jp/contests/abc146/tasks/abc146_b

def solve(io)
  n = io.get
  s = io.get(String)
  io.put s.chars.map { |si| 'A' + (((si - 'A') + n) % 26) }.join
end

require "lib/procon"

solve(ProconIO.new)
