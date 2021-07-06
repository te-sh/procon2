# URL: https://yukicoder.me/problems/no/836

def solve(io)
  l, r, n = io.get3(Int64)

  n.times do |j|
    io.put count_mod(r, j, n) - count_mod(l-1, j, n)
  end
end

def count_mod(i, j, n)
  i >= 0 ? (i-j) // n + 1 : 0
end

require "lib/procon"

solve(ProconIO.new)
