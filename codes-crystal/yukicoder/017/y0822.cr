# URL: https://yukicoder.me/problems/no/822

def main(io)
  n, k = io.get2
  io.put_e "INF" if n < k

  r = 0
  (0...1<<n.bit_length).each do |x|
    (x..x+k).each do |y|
      r += 1 if x & y == n
    end
  end

  io.put r
end

require "lib/procon_io"

main(ProconIO.new)
