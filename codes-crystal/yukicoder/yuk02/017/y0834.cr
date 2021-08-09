# URL: https://yukicoder.me/problems/no/834

def solve(io)
  n, m = io.get2

  io.put_e 1 if n == 1

  f = Fact(Mint).new(m)

  c = Mint.zero

  (0..m).each do |i|
    next unless (i % (n*2) == 0 || i % (n*2) == n*2-1) && (i+m) % 2 == 0
    x = (i+m) // 2
    c += f.combi(m, x)
  end

  (1..m).each do |i|
    next unless (i % (n*2) == 1 || i % (n*2) == 0) && (i+m) % 2 == 0
    x = (i+m) // 2
    c += f.combi(m, x)
  end

  io.put c
end

require "lib/math/fact"

require "lib/math/mod_int"
ModInt.new_type(Mint, 10**9+7)

require "lib/procon"

solve(ProconIO.new)
