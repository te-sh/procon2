# URL: https://yukicoder.me/problems/no/804

def solve(io)
  a, b, c, d = io.get4

  (0..a).reverse_each do |x|
    io.put_e x if x*c <= b && x+x*c <= d
  end
end

require "lib/procon"

solve(ProconIO.new)
