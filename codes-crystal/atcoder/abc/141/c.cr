# URL: https://atcoder.jp/contests/abc141/tasks/abc141_c

def main(io)
  n, k, q = io.get3

  b = Array.new(n, 0)
  q.times do
    ai = io.get; ai -= 1
    b[ai] += 1
  end

  b.each do |bi|
    io.put k-(q-bi) > 0 ? "Yes" : "No"
  end
end

require "lib/procon_io"

main(ProconIO.new)
