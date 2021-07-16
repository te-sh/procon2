# URL: https://atcoder.jp/contests/abc135/tasks/abc135_c

def solve(io)
  n = io.get
  a = io.get_a(n+1)
  b = io.get_a(n)

  r = 0_i64
  (n+1).times do |i|
    if i > 0
      c = Math.min(b[i-1], a[i])
      r += c
      b[i-1] -= c
      a[i] -= c
    end
    if i < n
      c = Math.min(b[i], a[i])
      r += c
      b[i] -= c
      a[i] -= c
    end
  end

  io.put r
end

require "lib/procon"

solve(ProconIO.new)
