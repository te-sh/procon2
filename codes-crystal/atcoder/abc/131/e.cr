# URL: https://atcoder.jp/contests/abc131/tasks/abc131_e

def main(io)
  n, k = io.get2
  io.put_e -1 if k > (n-1)*(n-2)//2

  io.put n*(n-1)//2-k

  (0...n-1).each do |i|
    (i+1...n-1).each do |j|
      if k > 0
        k -= 1
      else
        io.put i+1, j+1
      end
    end
  end

  (0...n-1).each do |i|
    io.put i+1, n
  end
end

require "lib/procon_io"

main(ProconIO.new)
