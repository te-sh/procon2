# URL: https://atcoder.jp/contests/abc151/tasks/abc151_d

def solve(io)
  h, w = io.get2

  g = Array.new_md(h + 2, w + 2, false)
  (1..h).each do |i|
    si = io.get(String)
    si.each_char_with_index(1) do |c, j|
      g[i][j] = c == '.'
    end
  end

  r = 0
  (1..h).each do |si|
    (1..w).each do |sj|
      next unless g[si][sj]
      v = Array.new_md(h + 2, w + 2, false)
      d = Array.new_md(h + 2, w + 2, 0)
      v[si][sj] = true
      q = Deque{ {si, sj} }
      until q.empty?
        ui, uj = q.shift
        [{ui - 1, uj}, {ui, uj + 1}, {ui + 1, uj}, {ui, uj - 1}].each do |vi, vj|
          next if !g[vi][vj] || v[vi][vj]
          d[vi][vj] = d[ui][uj] + 1
          v[vi][vj] = true
          q.push({vi, vj})
        end
      end
      max_u(r, d.max_of(&.max))
    end
  end

  io.put r
end

require "lib/procon"

solve(ProconIO.new)
