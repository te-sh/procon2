# URL: https://atcoder.jp/contests/abc156/tasks/abc156_d

def solve(io)
  n, a, b = io.get3

  r = Mint.new(2) ** n - 1

  r1 = Mint.new(1)
  (0...a).each do |i|
    r1 *= Mint.new(n - i) // Mint.new(a - i)
  end

  r2 = Mint.new(1)
  (0...b).each do |i|
    r2 *= Mint.new(n - i) // Mint.new(b - i)
  end

  io.put r - r1 - r2
end

require "lib/procon"

require "lib/math/mod_int"
ModInt.new_type(Mint, 10**9 + 7)

solve(ProconIO.new)
