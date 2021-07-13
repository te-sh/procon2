# URL: https://yukicoder.me/problems/no/764

def solve(io)
  n = io.get
  l = io.get_c(n+2, Float64)

  l0 = l[0]
  lc = CumulativeSum.new(l)

  ll = Array.new(n+2, 0.0)
  ll[1] = l[1]
  (2..n+1).each do |i|
    ll[i] = Math.max(ll[i-1], l[i])
  end

  lr = Array.new(n+2, 0.0)
  lr[n+1] = l[n+1]
  (1..n).reverse_each do |i|
    lr[i] = Math.max(lr[i+1], l[i])
  end

  io.put 0
  (2...n).each do |i|
    a = lc[1...i+1]
    b = (2 * ll[i] - a).clamp(0.0..)
    c = lc[i+1...]
    d = (2 * lr[i+1] - c).clamp(0.0..)

    io.put calc(l0, a, c) - calc(l0, a, d) - calc(l0, b, c) + calc(l0, b, d)
  end
  io.put 0
end

def integral(a, x)
  if (a-x).near_zero?
    a**2 * Math::PI / 2
  else
    x * Math.sqrt(a**2 - x**2) + a**2 * Math.asin(x / a)
  end
end

def calc(l0, r1, r2)
  if r1 + r2 < l0
    0.0
  elsif r1+l0 < r2
    Math::PI * r1**2
  elsif r2+l0 < r1
    Math::PI * r2**2
  else
    x = (l0**2 + r1**2 - r2**2) / (l0 * 2)
    integral(r2, x-l0) - integral(r2, -r2) + integral(r1, r1) - integral(r1, x)
  end
end

require "lib/procon"

require "lib/data_structure/cumulative_sum"

solve(ProconIO.new)
