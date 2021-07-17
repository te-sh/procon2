# URL: https://atcoder.jp/contests/sumitrust2019/tasks/sumitb2019_e

def solve(io)
  n = io.get
  a = io.get_a(n)

  a.map!(&.+ 1)
  c = Array.new(n + 1, 0)
  c[0] = 3

  r = Mint.new(1)
  n.times do |i|
    if c[a[i] - 1] > 0
      r *= c[a[i] - 1]
      c[a[i] - 1] -= 1
      c[a[i]] += 1
    else
      r = 0
    end
  end

  io.put r
end

require "lib/procon"

require "lib/math/mod_int"
ModInt.new_type(Mint, 10**9+7)

solve(ProconIO.new)
