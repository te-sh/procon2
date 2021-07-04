# URL: https://atcoder.jp/contests/abc133/tasks/abc133_b

def main(io)
  n, d = io.get2
  x = io.get_m(n, d)

  r = 0
  (0...n).each do |i|
    (i+1...n).each do |j|
      l = x[i].zip(x[j]).map { |xij1, xij2| (xij1 - xij2)**2 }.sum
      r += 1 if isqrt(l)**2 == l
    end
  end

  io.put r
end

require "lib/math/misc"

require "lib/procon_io"

main(ProconIO.new)