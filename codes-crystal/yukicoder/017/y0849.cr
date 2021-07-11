# URL: https://yukicoder.me/problems/no/849

def solve(io)
  a, b, c, d = io.get4(Int64)
  n = io.get
  x, y = io.get2_c(n, Int64)

  if a < c
    a, c = c, a
    b, d = d, b
  end

  if a == 0 && c == 0
    g = b.gcd(d)
    io.put_e zip(x, y).map { |xi, yi| {xi, yi % g} }.uniq.size
  end

  if b == 0 && d == 0
    g = a.gcd(c)
    io.put_e zip(x, y).map { |xi, yi| {xi % g, yi} }.uniq.size
  end

  while c > 0
    e = a // c
    a, c = c, a - e * c
    b, d = d, b - e * d
  end
  d = d.abs

  k = Array({Int64, Int64}).new
  zip(x, y).each do |xi, yi|
    e = xi // a
    x = xi - e * a
    y = yi - e * b
    k << {x, d != 0 ? y % d : y}
  end

  io.put k.uniq.size
end

require "lib/procon"

solve(ProconIO.new)
