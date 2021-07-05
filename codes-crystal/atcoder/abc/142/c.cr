# URL: https://atcoder.jp/contests/abc142/tasks/abc142_c

def main(io)
  n = io.get
  a = io.get_a(n)
  s = a.map_with_index { |ai, i| {a: ai, i: i+1} }
  s.sort_by! { |si| si[:a] }
  io.put s.map { |si| si[:i] }
end

require "lib/procon_io"

main(ProconIO.new)
