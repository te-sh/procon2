# URL: https://atcoder.jp/contests/abs/tasks/abc087_b

def main(io)
  a = io.get
  b = io.get
  c = io.get
  x = io.get

  d = 0
  (0..a).each do |i|
    (0..b).each do |j|
      (0..c).each do |k|
        d += 1 if i*500 + j*100 + k*50 == x
      end
    end
  end

  io.put d
end

require "lib/procon_io"

main(ProconIO.new)
