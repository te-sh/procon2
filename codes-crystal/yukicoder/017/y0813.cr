# URL: https://yukicoder.me/problems/no/813

def solve(io)
  n = io.get
  p = io.get(Float64)
  q = io.get(Float64)

  io.put_e 1 if p == 1

  p1, q1 = p, q
  (n-1).times do
    p1, q1 = p1 + (q1**2 * p) / (1 - p1 * p), (q1 * q) / (1 - p1 * p)
  end

  io.put p1
end

require "lib/procon"

solve(ProconIO.new)
