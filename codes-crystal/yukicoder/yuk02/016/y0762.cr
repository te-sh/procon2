# URL: https://yukicoder.me/problems/no/762

def solve(io)
  n, m = io.get2
  s = io.get(String)

  g = Graph.new(n)
  m.times do
    u, v = io.get2; u -= 1; v -= 1
    g.add_edge_b(u, v)
  end

  p = Array.new(n, Mint.zero)
  d = Array.new(n, Mint.zero)
  c = Array.new(n, Mint.zero)
  a = Array.new(n, Mint.zero)

  n.times do |i|
    if s[i] == 'P'
      p[i] = Mint.new(1)
    end
  end

  n.times do |i|
    if s[i] == 'P'
      g[i].each do |j|
        d[j] += p[i] if s[j] == 'D'
      end
    end
  end

  n.times do |i|
    if s[i] == 'D'
      g[i].each do |j|
        c[j] += d[i] if s[j] == 'C'
      end
    end
  end

  n.times do |i|
    if s[i] == 'C'
      g[i].each do |j|
        a[j] += c[i] if s[j] == 'A'
      end
    end
  end

  io.put a.sum
end

require "lib/procon"

require "lib/math/mod_int"
ModInt.new_type(Mint, 10**9+7)

require "lib/graph/graph"

solve(ProconIO.new)
