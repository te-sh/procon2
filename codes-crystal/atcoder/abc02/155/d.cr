# URL: https://atcoder.jp/contests/abc155/tasks/abc155_d

def solve(io)
  n, k = io.get(Int32, Int64)
  a = io.get_a(n, Int64)
  a.sort!

  r = (-(10_i64 ** 18) .. 10_i64 ** 18).bsearch do |x|
    c = 0_i64
    (0...n).each do |i|
      if a[i] >= 0
        d = (i + 1 ... n).bsearch { |j| a[i] * a[j] > x }
        c += d.nil? ? n - i - 1 : d - i - 1
      else
        d = (i + 1 ... n).bsearch { |j| a[i] * a[j] <= x }
        c += d.nil? ? 0 : n - d
      end
    end
    c >= k
  end

  io.put r
end

require "lib/procon"

solve(ProconIO.new)
