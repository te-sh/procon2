# URL: https://yukicoder.me/problems/no/893

def solve(io)
  n = io.get
  a = Array.new(n) do
    pi = io.get
    io.get_a(pi)
  end

  m = a.max_of(&.size)
  r = [] of Int32
  m.times do |i|
    n.times do |j|
      r << a[j][i] if i < a[j].size
    end
  end

  io.put r
end

require "lib/procon"

solve(ProconIO.new)
