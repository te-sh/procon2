# URL: https://atcoder.jp/contests/abc133/tasks/abc133_c

def main(io)
  l, r = io.get2
  n = m = 2019

  (l..Math.min(l+n-1, r)).each do |i|
    (i+1..Math.min(i+n, r)).each do |j|
      min_u(m, ((i%n) * (j%n))%n)
    end
  end

  io.put m
end

require "lib/math/misc"

require "lib/procon_io"

main(ProconIO.new)
