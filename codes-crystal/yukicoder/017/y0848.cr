# URL: https://yukicoder.me/problems/no/848

def solve(io)
  n, m, p, q, t = io.get5; p -= 1; q -= 1
  s = 0

  g = GraphW(Int64).new(n, 10_i64**18)
  m.times do
    ai, bi, ci = io.get(Int32, Int32, Int64); ai -= 1; bi -= 1
    g.add_edge_b(ai, bi, ci)
  end

  ds, dp, dq = [s, p, q].map { |u| g.dijkstra(u).dist }

  io.put_e -1 if ds[p]*2 > t || ds[q]*2 > t
  io.put_e t if ds[p]+dp[q]+dq[s] <= t

  r = 0
  (0...n).each do |i|
    (i...n).each do |j|
      next if ds[i]+dp[i]+dp[j]+ds[j] > t || ds[i]+dq[i]+ds[j]+dq[j] > t
      max_u(r, t - Math.max(dp[i]+dp[j], dq[i]+dq[j]))
    end
  end

  io.put r
end

require "lib/procon"

require "lib/graph/graph"

require "lib/graph/dijkstra"

solve(ProconIO.new)
