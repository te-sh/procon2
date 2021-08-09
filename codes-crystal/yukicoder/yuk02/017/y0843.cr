# URL: https://yukicoder.me/problems/no/843

def solve(io)
  n = io.get

  io.put_e 0 if n == 1

  p = PrimeFactor.new(n).primes

  b = Array.new(n+1, false)
  p.each do |pi|
    b[pi] = true
  end

  s = 0
  p.each do |pi|
    q = pi+2
    r = Math.isqrt(q)
    if r**2 == q && b[r]
      s += 1
    end
  end

  io.put s*2-1
end

require "lib/math/prime_factor"

require "lib/procon"

solve(ProconIO.new)
