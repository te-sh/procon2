# URL: https://atcoder.jp/contests/abc132/tasks/abc132_d

def main(io)
  n, k = io.get2
  f = Fact(Mint).new(n)

  (1..k).each do |i|
    if i-1 > n-k
      io.put 0
    else
      io.put f.combi(k-1, i-1) * f.combi(n-k+1, n-k-i+1)
    end
  end
end

require "lib/math/fact"

require "lib/math/mod_int"
mod_int(Mint, 1_000_000_007)

require "lib/procon_io"

main(ProconIO.new)
