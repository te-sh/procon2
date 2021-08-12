# URL: https://yukicoder.me/problems/no/897

def solve(io)
  q = io.get
  q.times do
    n, k = io.get2(Int64)

    if k == 1
      io.put n - 1
      next
    end

    i = 0
    loop do
      n -= k ** i
      break if n <= 0
      i += 1
    end
    io.put i
  end
end

require "lib/procon"

solve(ProconIO.new)
