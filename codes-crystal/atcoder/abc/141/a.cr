# URL: https://atcoder.jp/contests/abc141/tasks/abc141_a

W = { "Sunny" => "Cloudy", "Cloudy" => "Rainy", "Rainy" => "Sunny" }

def solve(io)
  s = io.get(String)
  io.put W[s]
end

require "lib/procon"

solve(ProconIO.new)
