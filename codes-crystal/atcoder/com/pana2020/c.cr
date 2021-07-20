# URL: https://atcoder.jp/contests/panasonic2020/tasks/panasonic2020_c

def solve(io)
  a, b, c = io.get3(Int64)
  io.put_e "No" if c - a - b < 0
  io.put a * b * 4 < (c - a - b)**2 ? "Yes" : "No"
end

require "lib/procon"

solve(ProconIO.new)
