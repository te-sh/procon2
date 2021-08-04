# URL: https://atcoder.jp/contests/abc150/tasks/abc150_d

def solve(io)
  n, m = io.get(Int32, Int64)
  a = io.get_a(n, Int64)
  b = a.map(&.// 2)

  l = 1_i64
  b.each do |bi|
    l = l.lcm(bi)
    io.put_e 0 if l > m
  end

  io.put_e 0 if b.any? { |bi| (l // bi).even? }

  io.put m // l - m // (l * 2)
end

require "lib/procon"

solve(ProconIO.new)
