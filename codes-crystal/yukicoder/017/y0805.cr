# URL: https://yukicoder.me/problems/no/805

def solve(io)
  n = io.get
  s = io.get(String)

  r = 0
  (0...n).each do |i|
    (i+1...n).each do |j|
      k = j + (j-i)
      next if k >= n
      r += 1 if s[i] == 'U' && s[j] == 'M' && s[k] == 'G'
    end
  end
  io.put r
end

require "lib/procon"

solve(ProconIO.new)
