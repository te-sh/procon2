# URL: https://atcoder.jp/contests/abc134/tasks/abc134_d

def solve(io)
  n = io.get
  a = io.get_a(n)

  b = Array.new(n+1, 0)
  (1..n).reverse_each do |i|
    c = i.step(to: n, by: i).map { |j| b[j] }.sum
    b[i] = a[i-1] ^ (c % 2)
  end

  io.put b.count(1)
  (1..n).each do |i|
    io.put i if b[i] == 1
  end
end

require "lib/procon"

solve(ProconIO.new)
