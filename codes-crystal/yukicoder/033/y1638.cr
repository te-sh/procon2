# URL: https://yukicoder.me/problems/no/1638

CELL = { '.' => 0, '@' => 1, '#' => 2 }

def solve(io)
  h, w = io.get2
  u, d, r, l, k, p = io.get6(Int64)
  xs, ys, xt, yt = io.get4; xs -= 1; ys -= 1; xt -= 1; yt -= 1
  c = io.get_c(h, String)

  e = c.map { |ci| ci.chars.map { |cij| CELL[cij] } }
  inf = 10_i64 ** 18
  cost = {
    u: { 0 => u, 1 => p + u, 2 => inf },
    d: { 0 => d, 1 => p + d, 2 => inf },
    r: { 0 => r, 1 => p + r, 2 => inf },
    l: { 0 => l, 1 => p + l, 2 => inf }
  }
  g = GraphW(Int64).new(h * w, inf)
  h.times do |i|
    (w - 1).times do |j|
      g.add_edge(idx(i, j), idx(i, j + 1), cost[:r][e[i][j + 1]])
      g.add_edge(idx(i, j + 1), idx(i, j), cost[:l][e[i][j]])
    end
  end
  w.times do |j|
    (h - 1).times do |i|
      g.add_edge(idx(i, j), idx(i + 1, j), cost[:d][e[i + 1][j]])
      g.add_edge(idx(i + 1, j), idx(i, j), cost[:u][e[i][j]])
    end
  end

  dist = g.dijkstra(idx(xs, ys)).dist
  io.put dist[idx(xt, yt)] <= k ? "Yes" : "No"
end

macro idx(r, c)
  ({{r}}) * w + ({{c}})
end

require "lib/procon"

require "lib/graph/graph"

require "lib/graph/dijkstra"

solve(ProconIO.new)
