# URL: https://yukicoder.me/problems/no/752

def solve(io)
  p, q = io.get(Int64, Int32)

  max_m = Math.min(p, 10_i64 ** 4)
  max_k = p // (max_m + 1)

  b = Array.new(max_k + 1, 0_i64)
  (1..max_k).each do |k|
    b[k] = b[k-1] + p % k
  end

  c = Array.new(max_m + 2, 0_i64)
  c[-1] = b[-1]
  (1..max_m).reverse_each do |m|
    u = p // (m + 1) + 1
    v = p // m
    c[m] = c[m+1] + p * (v-u+1) - m * (v * (v+1) - u * (u-1)) // 2
  end

  calc = ->(x : Int64) do
    if x <= max_k
      b[x]
    else
      m = p // x
      u = p // (m + 1) + 1
      c[m+1] + p * (x-u+1) - m * (x * (x+1) - u * (u-1)) // 2
    end
  end

  q.times do
    l, r = io.get2(Int64)
    io.put calc.call(r) - calc.call(l-1)
  end
end

require "lib/procon"

solve(ProconIO.new)
