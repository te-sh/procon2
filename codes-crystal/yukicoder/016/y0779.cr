# URL: https://yukicoder.me/problems/no/779

def solve(io)
  y, m, d = io.get3
  io.put (Time.local(1989, 1, 8)..Time.local(2019, 4, 30)).includes?(Time.local(y, m, d)) ? "Yes" : "No"
end

require "lib/procon"

solve(ProconIO.new)
