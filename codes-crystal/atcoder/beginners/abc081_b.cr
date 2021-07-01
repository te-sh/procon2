# URL: https://atcoder.jp/contests/abs/tasks/abc081_b

def main(io)
  n = io.get
  a = io.get_a(n)
  io.put a.map { |ai| num2(ai) }.min
end

def num2(n : Int32)
  c = 0
  while n%2 == 0
    n /= 2
    c += 1
  end
  c
end

require "lib/procon_io"

main(ProconIO.new)
