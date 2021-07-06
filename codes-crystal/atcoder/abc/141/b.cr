# URL: https://atcoder.jp/contests/abc141/tasks/abc141_b

def solve(io)
  s = io.get(String)
  io.put s.chars.each_with_index.all? { |si, i| i.even? && si != 'L' || i.odd? && si != 'R' } ? "Yes" : "No"
end

require "lib/procon"

solve(ProconIO.new)
