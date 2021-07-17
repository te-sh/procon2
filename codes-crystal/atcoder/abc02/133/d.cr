# URL: https://atcoder.jp/contests/abc133/tasks/abc133_d

def solve(io)
  n = io.get
  a = io.get_a(n, Int64)

  x = Array.new(n, 0_i64)
  x[0] = a.map_with_index { |ai, i| ai * (-1)**i }.sum // 2

  (1...n).each do |i|
    x[i] = a[i-1] - x[i-1]
  end

  io.put x.map { |xi| xi*2 }
end

require "lib/procon"

solve(ProconIO.new)
