# URL: https://atcoder.jp/contests/abc141/tasks/abc141_d

def solve(io)
  n, m = io.get2
  a = io.get_a(n)

  h = Heap.new(a) { |a, b| b <=> a }
  m.times do
    h.first //= 2
  end

  r = 0_i64
  until h.empty?
    r += h.pop
  end

  io.put r
end

require "lib/data_structure/heap"

require "lib/procon"

solve(ProconIO.new)
