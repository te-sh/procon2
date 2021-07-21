# URL: https://yukicoder.me/problems/no/794

def solve(io)
  n, k = io.get2
  a = io.get_a(n)

  g = a.group_by(&.> k // 2)
  g1, g2 = g.fetch(true, [] of Int32), g.fetch(false, [] of Int32)
  io.put_e 0 if g1.size > g2.size

  g1.sort! { |a, b| b <=> a }
  g2.sort!

  ans = Mint.new(1)
  (g2.size - g1.size).step(to: 2, by: -2) do |i|
    ans *= Mint.new(i) * (i-1) // 2 // (i // 2)
  end

  g1.each_with_index do |g1i, i|
    ans *= (g2.bsearch_index { |g2i| g1i + g2i > k } || g2.size) - i
  end

  io.put ans
end

require "lib/procon"

require "lib/math/mod_int"
ModInt.new_type(Mint, 10**9+7)

solve(ProconIO.new)
