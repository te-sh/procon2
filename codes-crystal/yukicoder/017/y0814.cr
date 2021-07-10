# URL: https://yukicoder.me/problems/no/814

def solve(io)
  n = io.get
  k, l, d = io.get_c(n, Int64, Int64, Int32)

  r = 0_i64
  zip(k, l, d) do |ki, li, di|
    x1 = ki.even? ? 0_i64 : li & ((1_i64 << di) - 1)
    x2 = cumulative_xor(li >> di, (li >> di) + (ki - 1)) << di
    r ^= x1 | x2
  end

  io.put r
end

def cumulative_xor(n1 : Int64, n2 : Int64)
  r = cumulative_xor(n2)
  n1 == 0 ? r : r ^ cumulative_xor(n1-1)
end

def cumulative_xor(n : Int64)
  case n % 4
  when 0; n
  when 1; 1_i64
  when 2; n + 1
  when 3; 0_i64
  else; raise "must not happen"
  end
end

require "lib/procon"

solve(ProconIO.new)
