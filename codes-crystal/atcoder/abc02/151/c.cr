# URL: https://atcoder.jp/contests/abc151/tasks/abc151_c

def solve(io)
  n, m = io.get2

  a = Array.new(n, false)
  w = Array.new(n, 0)
  sa = sw = 0
  m.times do
    p, s = io.get(Int32, String); p -= 1
    case s
    when "AC"
      unless a[p]
        sa += 1
        sw += w[p]
      end
      a[p] = true
    when "WA"
      w[p] += 1
    end
  end

  io.put sa, sw
end

require "lib/procon"

solve(ProconIO.new)
