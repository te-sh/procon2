# URL: https://yukicoder.me/problems/no/816

def solve(io)
  a, b = io.get2

  pf = PrimeFactor.sqrt(a+b)
  pf.divisors(a+b).each do |c|
    io.put_e c if a != c && b != c && (a+c)%b == 0 && (b+c)%a == 0
  end

  io.put -1
end

require "lib/procon"

require "lib/math/prime_factor"

solve(ProconIO.new)
