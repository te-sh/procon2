# URL: https://yukicoder.me/problems/no/756

def solve(io)
  s = (0...100).map(&.to_s).join
  d = io.get
  io.put s[d]
end

require "lib/procon"

solve(ProconIO.new)
