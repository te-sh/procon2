# URL: https://yukicoder.me/problems/no/885

def solve(io)
  n = io.get
  a = io.get_a(n, Int64)

  s = a.sum
  h = Heap.new(a) { |a, b| b <=> a }
  q = io.get
  q.times do
    xi = io.get
    while h.first >= xi
      f = h.first
      r = f % xi
      s -= f - r
      h.first = r
    end
    io.put s
  end
end

require "lib/procon"

require "lib/data_structure/heap"

solve(ProconIO.new)
