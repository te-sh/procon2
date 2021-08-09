# URL: https://yukicoder.me/problems/no/837

def solve(io)
  n = io.get
  y = io.get_a(n, Int64)

  y.sort!
  io.put_e 1 if y.all?(&.== y[0])

  cy = CumulativeSum.new(y)
  s = 10_i64**18
  (1..n-1).each do |i|
    m1 = i//2
    s1 = -cy[0...m1] + cy[m1...i] - (i.odd? ? y[m1] : 0)
    m2 = (n-i)//2+i
    s2 = -cy[i...m2] + cy[m2...n] - ((n-i).odd? ? y[m2] : 0)
    min_u(s, s1+s2)
  end

  io.put(s)
end

require "lib/data_structure/cumulative_sum"

require "lib/procon"

solve(ProconIO.new)
