# URL: https://yukicoder.me/problems/no/825

def main(io)
  a, b, c = io.get3

  m = 10**9
  (0..a).each do |i|
    (0..b).each do |j|
      (1..i+j*10).each do |k|
        p = i+j*10-k
        min_u(m, k) if c == (a-i)+(b-j)+p//10+p%10
      end
    end
  end

  io.put m == 10**9 ? "Impossible" : m
end

require "lib/math/misc"

require "lib/procon_io"

main(ProconIO.new)
