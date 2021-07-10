# URL: https://atcoder.jp/contests/abc131/tasks/abc131_f

def solve(io)
  n = io.get
  x, y = io.get2_c(n); x.map!(&.- 1); y.map!(&.- 1)

  m = 10**5
  g = Graph.new(m*2)
  (0...n).each do |i|
    g.add_edge_b(x[i], y[i]+m)
  end

  b = Array.new(m*2, false)
  r = 0_i64
  (0...m).each do |u|
    next if b[u]

    b[u] = true
    v = [u]
    q = Deque.new([u])

    until q.empty?
      i = q.shift
      g[i].each do |j|
        next if b[j]
        b[j] = true
        v << j
        q.push(j)
      end
    end
    next if v.size == 1

    vx = v.select { |vi| vi < m }
    vxe = vx.map { |vxi| g[vxi].size }.sum
    r += vx.size.to_i64 * (v.size - vx.size) - vxe
  end

  io.put r
end

require "lib/graph/graph"

require "lib/procon"

solve(ProconIO.new)
