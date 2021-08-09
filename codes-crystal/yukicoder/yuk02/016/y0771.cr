# URL: https://yukicoder.me/problems/no/771

def solve(io)
  n = io.get
  a, b = io.get2_c(n)

  memo = Array.new_md(n, 1 << n, -1)
  calc = uninitialized Int32, Int32 -> Int32
  calc = ->(i : Int32, s : Int32) do
    return 0 if s == 0
    return memo[i][s] if memo[i][s] >= 0

    m = 100_000
    n.times do |j|
      if s.bit?(j)
        min_u(m, Math.max((b[i] - a[i]) + a[j], calc.call(j, s.reset_bit(j))))
      end
    end

    memo[i][s] = m
  end

  io.put (0...n).map { |i| calc.call(i, ((1 << n) - 1).reset_bit(i)) }.min
end

require "lib/procon"

solve(ProconIO.new)
