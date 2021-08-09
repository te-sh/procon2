# URL: https://yukicoder.me/problems/no/791

def solve(io)
  s = io.get(String)
  io.put s.size > 1 && s[0] == '1' && s.chars.count('3') == s.size - 1 ? s.size - 1 : -1
end

require "lib/procon"

solve(ProconIO.new)
