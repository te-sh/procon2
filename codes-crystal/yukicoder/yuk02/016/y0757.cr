# URL: https://yukicoder.me/problems/no/757

require "big"

def solve(io)
  b = io.get
  s = io.get(String)
  d = s.to_big_i(b) - 1

  io.put_e 1 if d == 1

  len = ->(x : Int32) do
    bp = b.to_big_i ** x
    bp * x - (bp - 1) // (b - 1)
  end

  f = (0..s.size).bsearch { |x| len.call(x) > d } || s.size + 1
  d -= len.call(f-1)

  g = (d // f) + (b.to_big_i ** (f - 1))
  h = d % f
  io.put g.to_s(b)[h]
end

require "lib/procon"

solve(ProconIO.new)
