# URL: https://yukicoder.me/problems/no/851

def solve(io)
  n = read_line.to_i64
  a1 = read_line
  io.put_e "\"assert\"" if a1.includes?(' ')
  a1 = a1.to_i64
  a2 = read_line.to_i64
  a3 = read_line.to_i64

  io.put [a1+a2, a2+a3, a3+a1].sort.uniq[-2]
end

require "lib/procon"

solve(ProconIO.new)
