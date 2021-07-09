# URL: https://yukicoder.me/problems/no/811

def solve(io)
  n, k = io.get2

  pf = PrimeFactor.sqrt(n)
  dn = pf.div(n)
  fn = dn.flat_map { |f| (1..f.exp).map { |e| f.prime ** e } }

  r = ri = 0
  (1...n).each do |i|
    di = pf.div(i)
    fi = di.flat_map { |f| (1..f.exp).map { |e| f.prime ** e } }
    next if (fn & fi).size < k

    ds = di.map(&.exp).map(&.+ 1).product
    if ds > r
      r = ds
      ri = i
    end
  end

  io.put ri
end

require "lib/procon"

require "lib/math/prime_factor"

solve(ProconIO.new)
