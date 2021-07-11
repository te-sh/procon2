# URL: https://yukicoder.me/problems/no/754

def solve(io)
  n = io.get
  a = io.get_c(n+1)
  b = io.get_c(n+1)

  s = sb = Mint.zero
  (0..n).each do |i|
    sb += b[i]
    s += sb * a[n-i]
  end

  io.put s
end

require "lib/procon"

require "lib/math/mod_int"
ModInt.new_type(Mint, 10**9+7)

solve(ProconIO.new)
