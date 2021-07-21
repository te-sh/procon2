# URL: https://yukicoder.me/problems/no/782

def solve(io)
  t, b = io.get2
  c = b.abs

  t.times do
    n = io.get

    if n == 0
      io.put 0
      next
    end

    r = [] of Int32
    until n == 0
      m = (n % b - b) % (-b)
      r << m
      n = (n - m) // b
    end

    io.put r.map { |ri| '0' + ri }.reverse.join
  end
end

require "lib/procon"

solve(ProconIO.new)
