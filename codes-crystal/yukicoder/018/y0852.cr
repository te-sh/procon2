# URL: https://yukicoder.me/problems/no/852

def solve(io)
  s = io.get(String)
  n = s.size

  a = Array.new(26) { [] of Int32 }
  s.each_char.with_index do |si, i|
    a[si - 'a'] << i
  end

  r = 0.0
  a.each do |ai|
    ri = 0.0
    ([-1] + ai + [n]).each_cons_pair do |i, j|
      ri += (j - i).to_f64 * (j - i - 1) / 2
    end
    r += 1 - ri / ((n + 1).to_f64 * n / 2)
  end

  io.put r
end

require "lib/procon"

solve(ProconIO.new)
