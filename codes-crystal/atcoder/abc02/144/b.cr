# URL: https://atcoder.jp/contests/abc144/tasks/abc144_b

def solve(io)
  n = io.get
  (1..9).to_a.each_repeated_combination(2) do |(a, b)|
    io.put_e "Yes" if a * b == n
  end
  io.put "No"
end

require "lib/procon"

solve(ProconIO.new)
