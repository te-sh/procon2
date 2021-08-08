# URL: https://atcoder.jp/contests/abc146/tasks/abc146_c

def solve(io)
  a, b, x = io.get3(Int64)

  (1..10).reverse_each do |i|
    n = (x - b * i) // a
    if i == 10 && n >= 10 ** 9
      io.put_e 10 ** 9
    elsif i <= 9 && n >= 10 ** (i - 1)
      io.put_e({n, 10 ** i - 1}.min)
    end
  end

  io.put 0
end

require "lib/procon"

solve(ProconIO.new)
