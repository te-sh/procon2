# URL: https://atcoder.jp/contests/abc146/tasks/abc146_a

NEXT_SUNDAY = {
  "SUN" => 7, "MON" => 6, "TUE" => 5, "WED" => 4,
  "THU" => 3, "FRI" => 2, "SAT" => 1
}

def solve(io)
  s = io.get(String)
  io.put NEXT_SUNDAY[s]
end

require "lib/procon"

solve(ProconIO.new)
