# URL: https://yukicoder.me/problems/no/831

def main(io)
  n = io.get
  p = Array.new(n, 0)

  io.put_e 0 if n == 1

  (0...n//2).each do |i|
    if i.even?
      p[i] = i+1
      p[-1-i] = n-i
    else
      p[i] = n-i
      p[-1-i] = i+1
    end
  end
  p[n//2] = n//2+1 if n.odd?

  r = n.to_i64
  p.each_cons_pair do |i, j|
    r += i.to_i64*j
  end
  io.put r
end

require "lib/procon_io"

main(ProconIO.new)
