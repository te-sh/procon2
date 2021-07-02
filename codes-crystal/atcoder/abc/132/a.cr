# URL: https://atcoder.jp/contests/abc132/tasks/abc132_a

def main(io)
  s = io.get(String)
  t = s.chars.sort
  io.put t[0] == t[1] && t[1] != t[2] && t[2] == t[3] ? "Yes" : "No"
end

require "lib/procon_io"

main(ProconIO.new)
