# URL: https://yukicoder.me/problems/no/817

def solve(io)
  n, k = io.get2
  a, b = io.get2_c(n)
  am = a.map(&.- 1)
  bp = b.map(&.+ 1)

  z = Zaatsu.new(a, b, am, bp)
  c = Array.new(z.size + 1, 0)
  zip(a, b).each do |ai, bi|
    c[z.comp(ai)] += 1
    c[z.comp(bi+1)] -= 1
  end
  z.size.times do |i|
    c[i+1] += c[i]
  end

  z.size.times do |i|
    m = c[i] * (z.uncomp(i+1) - z.uncomp(i))
    if k > m
      k -= m
    else
      io.put_e z.uncomp(i) + (k-1)//c[i]
    end
  end
end

require "lib/procon"

require "lib/data_structure/zaatsu"

solve(ProconIO.new)
