# URL: https://atcoder.jp/contests/abc131/tasks/abc131_a

def main(io)
  s = io.get(String)
  io.put s.chars.each.cons_pair.any? { |a, b| a == b } ? "Bad" : "Good"
end

require "lib/procon_io"

main(ProconIO.new)
