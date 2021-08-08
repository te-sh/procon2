# URL: https://atcoder.jp/contests/abc157/tasks/abc157_b

def solve(io)
  a = io.get_m(3, 3)
  n = io.get
  b = io.get_c(n)

  m = Array.new_md(3, 3, false)
  b.each do |bi|
    (0...3).each do |i|
      (0...3).each do |j|
        m[i][j] = true if a[i][j] == bi
      end
    end
  end

  [
    [{0, 0}, {0, 1}, {0, 2}],
    [{1, 0}, {1, 1}, {1, 2}],
    [{2, 0}, {2, 1}, {2, 2}],
    [{0, 0}, {1, 0}, {2, 0}],
    [{0, 1}, {1, 1}, {2, 1}],
    [{0, 2}, {1, 2}, {2, 2}],
    [{0, 0}, {1, 1}, {2, 2}],
    [{2, 0}, {1, 1}, {0, 2}]
  ].each do |d|
    io.put_e "Yes" if d.all? { |i, j| m[i][j] }
  end

  io.put "No"
end

require "lib/procon"

solve(ProconIO.new)
