# URL: https://yukicoder.me/problems/no/812

def solve(io)
  n, m = io.get2
  g = Graph.new(n)
  m.times do
    pi, qi = io.get2; pi -= 1; qi -= 1
    g.add_edge_b(pi, qi)
  end

  q = io.get
  q.times do
    ai = io.get; ai -= 1
    d = Array.new(n, 0)
    s, m = 0, 0
    g.bfs(ai) do |u, p|
      d[u] = d[p] + 1 if p != -1
      s += 1
      max_u(m, d[u])
    end

    x = 0
    while m > 1
      m = m.cdiv(2)
      x += 1
    end
    io.put s-1, x
  end
end

require "lib/procon"

require "lib/graph/graph"

solve(ProconIO.new)
