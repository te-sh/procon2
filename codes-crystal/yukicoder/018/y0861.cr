# URL: https://yukicoder.me/problems/no/861

def solve(io)
  c = io.get_m(5, 5, Int64)
  d = c.flatten
  ds = d.sum

  s = [0]
  (1..15).each do |i|
    (0..15-i).each do |j|
      s << (((1 << i) - 1) << j)
    end
  end

  r = 10_i64**18
  s.each do |si|
    (1 << 9).times do |ti|
      p = 0
      {0, 1, 2, 3, 4, 9, 14, 19, 24, 23, 22, 21, 20, 15, 10, 5}.each_with_index do |i, j|
        p = p.set_bit(i) if si.bit?(j)
      end
      {6, 7, 8, 11, 12, 13, 16, 17, 18}.each_with_index do |i, j|
        p = p.set_bit(i) if ti.bit?(j)
      end

      uf = UnionFind.new(25)
      5.times do |i|
        4.times do |j|
          x1 = i * 5 + j
          x2 = x1 + 1
          uf.unite(x1, x2) if p.bit?(x1) == p.bit?(x2)

          y1 = j * 5 + i
          y2 = y1 + 5
          uf.unite(y1, y2) if p.bit?(y1) == p.bit?(y2)
        end
      end
      next unless uf.count_forests == 2

      e = 0_i64
      25.times do |i|
        e += d[i] unless p.bit?(i)
      end
      min_u(r, (e * 2 - ds).abs)
    end
  end

  io.put r
end

require "lib/procon"

require "lib/data_structure/union_find"

solve(ProconIO.new)
