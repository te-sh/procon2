# URL: https://atcoder.jp/contests/abc140/tasks/abc140_b

def main(io)
  n = io.get
  a = io.get_a(n); a.map!(&.-(1))
  b = io.get_a(n)
  c = io.get_a(n-1)

  r = 0
  (0...n).each do |i|
    r += b[a[i]]
    r += c[a[i-1]] if i > 0 && a[i] == a[i-1] + 1
  end

  io.put r
end

require "lib/procon_io"

main(ProconIO.new)
