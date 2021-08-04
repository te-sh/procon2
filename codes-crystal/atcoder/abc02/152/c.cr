# URL: https://atcoder.jp/contests/abc152/tasks/abc152_c

def solve(io)
  n = io.get
  p = io.get_a(n)

  r = 0
  m = n + 1
  p.each do |pi|
    if pi < m
      r += 1
      m = pi
    end
  end

  io.put r
end

require "lib/procon"

solve(ProconIO.new)
