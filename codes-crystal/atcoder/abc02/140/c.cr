# URL: https://atcoder.jp/contests/abc140/tasks/abc140_c

def main(io)
  n = io.get
  b = io.get_a(n-1)

  r = b[0] + b[-1]
  (1...n-1).each do |i|
    r += Math.min(b[i-1], b[i])
  end

  io.put r
end

require "lib/procon_io"

main(ProconIO.new)
