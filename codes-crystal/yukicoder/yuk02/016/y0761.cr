# URL: https://yukicoder.me/problems/no/761

def solve(io)
  n = io.get
  a = io.get_a(n, Int64)

  ac = CumulativeSum.new(a)

  calc = uninitialized (Int32, Int32) -> Bool
  calc = ->(l : Int32, r : Int32) do
    return true if a[l] == a[r-1]

    b = (ac[l...r] + (r-l) - 1) // (r-l)
    i = a.bsearch_index { |ai| ai >= b } || a.size

    c1 = calc.call(l, i)
    c2 = calc.call(i, r)
    !c1 || !c2
  end

  io.put calc.call(0, n) ? "First" : "Second"
end

require "lib/procon"

require "lib/data_structure/cumulative_sum"

solve(ProconIO.new)
