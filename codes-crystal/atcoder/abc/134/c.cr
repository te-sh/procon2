# URL: https://atcoder.jp/contests/abc134/tasks/abc134_c

def solve(io)
  n = io.get
  a = io.get_c(n)

  b = a.sort { |a, b| b <=> a }
  if b[0] == b[1]
    n.times do
      io.put b[0]
    end
  else
    i = a.index(b[0])
    n.times do |j|
      io.put j == i ? b[1] : b[0]
    end
  end
end

require "lib/procon"

solve(ProconIO.new)
