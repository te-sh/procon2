# URL: https://yukicoder.me/problems/no/841

def solve(io)
  s1, s2 = io.get2(String)
  if %w[Sat Sun].includes?(s1) && %[Sat Sun].includes?(s2)
    io.put "8/33"
  elsif %w[Sat Sun].includes?(s1)
    io.put "8/32"
  else
    io.put "8/31"
  end
end

require "lib/procon"

solve(ProconIO.new)
