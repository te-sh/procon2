# URL: https://yukicoder.me/problems/no/751

require "big"

def solve(io)
  n1 = io.get
  a = io.get_a(n1, Int32)
  n2 = io.get
  b = io.get_a(n2, Int32)

  ra = BigRational.new(a[0], 1)
  (1...n1).each do |i|
    ra /= a[i]
  end

  rb = BigRational.new(b[-1], 1)
  (0...n2-1).reverse_each do |i|
    rb = b[i] / rb
  end

  r = ra / rb
  io.put r.numerator, r.denominator
end

require "lib/procon"

solve(ProconIO.new)
