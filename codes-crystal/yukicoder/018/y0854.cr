# URL: https://yukicoder.me/problems/no/854

def solve(io)
  n = io.get
  a = io.get_a(n)

  pf = PrimeFactor.new(2000)
  np = pf.primes.size

  zcs = CumulativeSum.new(a.map { |ai| ai == 0 ? 1 : 0 })

  cs = Array(CumulativeSum(Int32)).new(np)
  pf.primes.each_with_index do |pi, j|
    b = Array.new(n, 0)
    (0...n).each do |i|
      while a[i] > 1 && a[i] % pi == 0
        b[i] += 1
        a[i] //= pi
      end
    end
    cs << CumulativeSum.new(b)
  end

  q = io.get
  q.times do
    p, l, r = io.get3; l -= 1; r -= 1

    if zcs[l..r] > 0
      io.put "Yes"
      next
    end

    ans = true
    pf.primes.each_with_index do |pi, j|
      c = 0
      while p % pi == 0
        c += 1
        p //= pi
      end
      if c > cs[j][l..r]
        ans = false
        break
      end
    end

    io.put p == 1 && ans ? "Yes" : "NO"
  end
end

require "lib/procon"

require "lib/data_structure/cumulative_sum"

require "lib/math/prime_factor"

solve(ProconIO.new)
