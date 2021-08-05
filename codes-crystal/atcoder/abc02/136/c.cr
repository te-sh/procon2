# URL: https://atcoder.jp/contests/abc136/tasks/abc136_c

def solve(io)
  n = io.get
  h = io.get_a(n)

  (0...(n - 1)).reverse_each do |i|
    io.put_e "No" if h[i] > h[i + 1] + 1
    h[i] -= 1 if h[i] == h[i + 1] + 1
  end

  io.put "Yes"
end

require "lib/procon"

solve(ProconIO.new)
