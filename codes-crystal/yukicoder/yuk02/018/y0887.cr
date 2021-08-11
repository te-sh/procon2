# URL: https://yukicoder.me/problems/no/887

def solve(io)
  n = io.get
  m = n
  i = 0
  while n > 1
    n = n.even? ? n // 2 : n * 3 + 1
    max_u(m, n)
    i += 1
  end
  io.put i
  io.put m
end

require "lib/procon"

solve(ProconIO.new)
