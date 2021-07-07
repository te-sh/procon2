# URL: https://yukicoder.me/problems/no/847

def solve(io)
  n, k, m = io.get3

  pf = PrimeFactor.sqrt(n)
  d = pf.div(n)

  num_divisors = uninitialized (Int32, Int64) -> Int32
  num_divisors = ->(i : Int32, j : Int64) do
    return 1 if i == d.size

    c = 0
    (0..d[i].exp.to_i64 * k).each do |e|
      nj = j * d[i].prime.to_i64 ** e
      break if nj > m
      c += num_divisors.call(i+1, nj)
    end

    c
  end

  io.put num_divisors.call(0, 1_i64)
end

require "lib/procon"

require "lib/math/prime_factor"

solve(ProconIO.new)
