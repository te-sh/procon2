# URL: https://atcoder.jp/contests/abs/tasks/abc085_c

def main(io)
  n, y = io.get_v(2)

  (0..n).each do |i|
    (0..n).each do |j|
      k = n-i-j
      next if k < 0
      io.put_e i, j, k if i*10000 + j*5000 + k*1000 == y
    end
  end
  io.put -1, -1, -1
end

require "lib/procon_io"

main(ProconIO.new)
