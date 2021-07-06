# URL: https://yukicoder.me/problems/no/823

def solve(io)
  n, k = io.get2
  f = Fact(Mint).new(n)

  if n == 1
    io.put_e 0
  elsif k == 1
    io.put Mint.new(n-1)*n*(n+1)//2
  elsif n == k
    io.put f.combi(k, 2)*f.perm(n-2, k-2)*n*(n-1)//2
  else
    io.put f.perm(n-1, k)*n*(n+1)//2 + f.combi(k, 2)*f.perm(n-2, k-2)*n*(n-1)//2
  end
end

require "lib/math/fact"

require "lib/math/mod_int"
struct Mint < ModInt; @@mod : Int32 = 10**9+7; end

require "lib/procon"

solve(ProconIO.new)
