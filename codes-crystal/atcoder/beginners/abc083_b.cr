# URL: https://atcoder.jp/contests/abs/tasks/abc083_b

def main(io)
  n, a, b = io.get_v(3)
  io.put (1..n).select { |i| (a..b).includes?(sum_digits(i)) }.sum
end

def sum_digits(n : Int)
  s = 0
  while n > 0
    s += n%10
    n //= 10
  end
  s
end

require "lib/procon_io"

main(ProconIO.new)
