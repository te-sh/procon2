# URL: https://yukicoder.me/problems/no/883

def solve(io)
  n, k = io.get2

  m = n.cdiv(k)
  if m >= k
    io.put m
    c = Array.new(m, '.')
    r = n
    m.times do |i|
      c.fill('.')
      s = {k, r}.min
      s.times do |j|
        c[(i + j) % m] = '#'
      end
      io.put c, delimiter: ""
      r -= s
    end
  else
    m = Math.isqrt(n)
    m += 1 if m ** 2 < n
    io.put m
    c = Array.new(m, '.')
    r = n
    m.times do |i|
      c.fill('.')
      s = {m, r}.min
      s.times do |j|
        c[j] = '#'
      end
      io.put c, delimiter: ""
      r -= s
    end
  end
end

require "lib/procon"

solve(ProconIO.new)
